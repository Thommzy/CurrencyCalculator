//
//  CountryListViewController.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/18/23.
//

import UIKit
import Combine

// MARK: - CountryListViewControllerDelegate Protocol

protocol CountryListViewControllerDelegate: AnyObject {
    func getCurrencyData(
        currencyType: CurrencyType,
        sourceCurrency: String,
        targetCurrency: String
    )
}

// MARK: - CountryListViewController Class

class CountryListViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var countryList: UITableView!
    
    // MARK: - Properties
    
    var list: [(String, Double)] = []
    var backupList: [(String, Double)] = []
    
    weak var delegate: CountryListViewControllerDelegate?
    var currencyType: CurrencyType = .sourceCurrency
    var currencyTuple = [(String?, String?)]()
    var amounToConvert: Double = 0.0
    
    // ViewModel and Combine-related properties
    let searchManager = SearchManager()
    lazy var countryListViewModel = CountryListViewModel(
        searchManager: searchManager
    )
    var cancellable = Set<AnyCancellable>()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupCountryList()
    }
    
    // MARK: - ViewModel Binding
    
    private func bindViewModel() {
        countryListViewModel.filteredList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] list in
                self?.list = list
                self?.countryList.reloadData()
            }
            .store(in: &cancellable)
    }
    
    // MARK: - Actions
    
    @IBAction func txtDidChange(_ sender: UITextField) {
        // Send the search string and the current list and backup list to the ViewModel for filtering.
        countryListViewModel.searchStringAndList.send(
            (
                sender.text,
                list,
                backupList
            )
        )
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: - CountryListViewController Extension

extension CountryListViewController {
    // MARK: - Setup Country List
    
    func setupCountryList() {
        countryList.register(
            UINib(nibName: "CountryTableViewCell", bundle: nil),
            forCellReuseIdentifier: CountryTableViewCell.identifier
        )
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource Extensions

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell or create a new one if not available.
        var cell: CountryTableViewCell? = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(CountryTableViewCell.identifier, owner: self, options: nil)?.first as? CountryTableViewCell
        }
        // Populate the cell with data from the list.
        cell?.data = list[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Notify the delegate about the selected currency data and dismiss the view controller.
        let item = list[indexPath.row]
        delegate?.getCurrencyData(
            currencyType: currencyType,
            sourceCurrency: currencyType == .sourceCurrency ? item.0 : currencyTuple[0].0 ?? "",
            targetCurrency: currencyType == .targetCurrency ? item.0 : currencyTuple[0].1 ?? ""
        )
        self.dismiss(animated: true)
    }
}
