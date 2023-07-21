//
//  HomeViewController.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/13/23.
//

import UIKit
import RealmSwift
import Combine

enum CurrencyType {
    case sourceCurrency
    case targetCurrency
}

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var currencyOne: CurrencyButtonView!
    @IBOutlet weak var currencyTwo: CurrencyButtonView!
    @IBOutlet weak var baseTextField: PrimaryTextFieldView!
    @IBOutlet weak var secondaryTextField: PrimaryTextFieldView!
    @IBOutlet weak var timeLabel: UnderlinedButton!
    
    let homeNetworkService = HomeNetworkService()
    let persistenceManager = PersistenceManager()
    
    
    lazy var homeViewModel = HomeViewmodel(
        networkService: homeNetworkService,
        realmDataManager: persistenceManager
    )
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        bindViewModel()
        setupActions()
        setupTimeLabel()
        homeViewModel.setupTimer()
        
    }
    
    private func bindViewModel() {
        
        homeViewModel.hasSessionExpired
            .receive(on: DispatchQueue.main)
            .filter {$0 == true}
            .sink { [weak self] expire in
                let format = 1
                self?.homeViewModel.getRates(
                    accessKey: self?.homeViewModel.getAccessKey() ?? "",
                    format: format
                )
            }
            .store(in: &cancellable)
        
        homeViewModel.hasSessionExpired
            .receive(on: DispatchQueue.main)
            .filter {$0 == false}
            .sink { [weak self] expire in
                self?.homeViewModel.getDataFromDB()
            }
            .store(in: &cancellable)
        
        homeViewModel.currencyOneCurrencyCode
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currCode in
                self?.baseTextField.rightLabelText = currCode
                self?.currencyOne.currencyText = "\(currCode)"
                self?.currencyOne.customFlag = currCode
            }
            .store(in: &cancellable)
        
        homeViewModel.currencyTwoCurrencyCode
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currCode in
                self?.secondaryTextField.rightLabelText = currCode
                self?.currencyTwo.currencyText = "\(currCode)"
                self?.currencyTwo.customFlag = currCode
            }
            .store(in: &cancellable)
        
        homeViewModel.displayError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errs in
                self?.showAlert(title: "Error", subtitle: errs)
            }
            .store(in: &cancellable)
    }
    
    private func setupTimeLabel() {
        let currentTime = Date().getCurrentTimeInUTCFormat()
        timeLabel.titleLabel?.text = "Mid market exchange rate at \(currentTime) UTC"
        timeLabel.customFont = 13
    }
    
    @IBAction func convertBtnAction(_ sender: UIButton) {
        self.evaluateData()
    }
    
    private func evaluateData() {
        if !baseTextField.getText().isEmpty  {
            let exchangeRateProvider = ExchangeRateProvider(rates: homeViewModel.rateArray.value)
            let currencyCalculator = CurrencyCalculator(exchangeRateProvider: exchangeRateProvider)
            if let convertedAmount = currencyCalculator.convert(
                amount: Double(self.baseTextField.getText()) ?? 0.0,
                from: homeViewModel.currencyOneCurrencyCode.value,
                to: homeViewModel.currencyTwoCurrencyCode.value
            ) {
                secondaryTextField.setText(newText: convertedAmount.convertDoubleToString())
            }
        } else {
            secondaryTextField.setText(newText: "")
        }
    }
}

extension HomeViewController {
    func setupActions() {
        currencyOne.onTap = { [weak self] in
            let vc = CountryListViewController(nibName: "CountryListViewController", bundle: nil)
            vc.list = self?.homeViewModel.rateArray.value ?? [(String, Double)]()
            vc.backupList = self?.homeViewModel.rateArray.value ?? [(String, Double)]()
            vc.delegate = self
            vc.currencyType = .sourceCurrency
            vc.currencyTuple = [
                (
                    self?.homeViewModel.currencyOneCurrencyCode.value,
                    self?.homeViewModel.currencyTwoCurrencyCode.value
                )
            ]
            self?.present(vc, animated: true)
        }
        
        currencyTwo.onTap = { [weak self] in
            let vc = CountryListViewController(nibName: "CountryListViewController", bundle: nil)
            vc.list = self?.homeViewModel.rateArray.value ?? [(String, Double)]()
            vc.backupList = self?.homeViewModel.rateArray.value ?? [(String, Double)]()
            vc.delegate = self
            vc.currencyType = .targetCurrency
            vc.currencyTuple = [
                (
                    self?.homeViewModel.currencyOneCurrencyCode.value,
                    self?.homeViewModel.currencyTwoCurrencyCode.value
                )
            ]
            self?.present(vc, animated: true)
        }
    }
}

extension HomeViewController: CountryListViewControllerDelegate {
    func getCurrencyData(
        currencyType: CurrencyType,
        sourceCurrency: String,
        targetCurrency: String
    ) {
        if currencyType == .targetCurrency {
            secondaryTextField.setText(newText: "")
        }
        homeViewModel.currencyOneCurrencyCode.send(sourceCurrency)
        homeViewModel.currencyTwoCurrencyCode.send(targetCurrency)
    }
}
