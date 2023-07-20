//
//  HomeViewController.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/13/23.
//

import UIKit
import RealmSwift
import Combine

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var currencyOne: CurrencyButtonView!
    @IBOutlet weak var currencyTwo: CurrencyButtonView!
    @IBOutlet weak var baseTextField: PrimaryTextFieldView!
    @IBOutlet weak var secondaryTextField: PrimaryTextFieldView!
    
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
        
        
        let accessKey = "f697f31013afb0f8abdc9727f2e82025"
        let format = 1
        
        homeViewModel.getRates(accessKey: accessKey, format: format)
        
        // Get the Realm file URL
        if let realmURL = Realm.Configuration.defaultConfiguration.fileURL {
            let realmPath = realmURL.path
            print("Realm file path: \(realmPath)")
        }
    }
    
    private func bindViewModel() {
        homeViewModel.currencyTwoCurrencyCode
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currCode in
                self?.secondaryTextField.rightLabelText = currCode
                self?.currencyTwo.currencyText = "\(currCode)"
                self?.currencyTwo.customFlag = currCode
                debugPrint("currencyOne--->>", currCode)
            }
            .store(in: &cancellable)
        
        
        homeViewModel.currencyTwoRate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currRate in
                self?.secondaryTextField.customPlaceHolder = "\(currRate)"
                debugPrint("currencyTwoRate--->>", currRate)
            }
            .store(in: &cancellable)
        
        homeViewModel.currencyOneCurrencyCode
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currCode in
                self?.currencyOne.currencyText = "\(currCode)"
                self?.currencyOne.customFlag = currCode
                debugPrint("currencyTwoRate--->>", currCode)
            }
            .store(in: &cancellable)
        
        homeViewModel.rateArray
            .receive(on: DispatchQueue.main)
            .sink { [weak self] arr in
                debugPrint("rateArray--->>", arr)
            }
            .store(in: &cancellable)
    }
    
    @IBAction func convertBtnAction(_ sender: UIButton) {
        debugPrint("convertBtnAction-->>")
    }
}

extension HomeViewController {
    func setupActions() {
        currencyOne.onTap = { [weak self] in
            let vc = CountryListViewController(nibName: "CountryListViewController", bundle: nil)
            vc.list = self?.homeViewModel.rateArray.value ?? [(String, Double)]()
            self?.present(vc, animated: true)
            debugPrint("currencyOne--->>>")
        }
        
        currencyTwo.onTap = { [weak self] in
            let vc = CountryListViewController(nibName: "CountryListViewController", bundle: nil)
            vc.list = self?.homeViewModel.rateArray.value ?? [(String, Double)]()
            self?.present(vc, animated: true)
            debugPrint("currencyTwo--->>>")
        }
    }
}
