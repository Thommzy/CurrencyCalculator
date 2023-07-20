//
//  CountryListViewModel.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/20/23.
//

import Foundation
import Combine

class CountryListViewModel {
    // MARK: - Properties
    
    // A PassthroughSubject to handle the incoming search string, original list, and backup list.
    var searchStringAndList = PassthroughSubject<(
        String?,
        StringDoubleTuple,
        StringDoubleTuple
    ), Never>()
    
    // A PassthroughSubject to send the filtered list of tuples to the view.
    var filteredList = PassthroughSubject<StringDoubleTuple, Never>()
    
    // A CurrentValueSubject to hold the current rate array (list of tuples with currency codes and rates).
    var rateArray = CurrentValueSubject<[(String, Double)], Never>([(String, Double)]())
    
    // A set to hold the cancellable Combine subscriptions.
    var cancellable = Set<AnyCancellable>()
    
    // A protocol instance to handle currency code search operations.
    private let searchManager: SearchManagerProtocol
    
    // MARK: - Initialization
    
    init(
        searchManager: SearchManagerProtocol
    ) {
        self.searchManager = searchManager
        setupViewModel()
    }
    
    // MARK: - Setup ViewModel
    
    // This function sets up the ViewModel and establishes Combine subscriptions.
    func setupViewModel() {
        searchStringAndList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] itemData in
                var tempData = itemData
                // Call the searchCurrencyCode method to filter the currency codes based on the search string.
                let data = self?.searchManager.searchCurrencyCode(
                    str: tempData.0 ?? "",
                    arr: &tempData.1,
                    backupArr: tempData.2
                )
                guard let data = data else { return }
                // Send the filtered list of tuples to the view.
                self?.filteredList.send(data)
            }
            .store(in: &cancellable)
    }
}
