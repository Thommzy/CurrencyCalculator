//
//  CountryListViewModel.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/20/23.
//

import Foundation
import Combine

class CountryListViewModel {
    var searchStringAndList = PassthroughSubject<(String?, [(String, Double)]), Never>()
    var filteredList = PassthroughSubject<StringDoubleTuple, Never>()
    var rateArray = CurrentValueSubject<[(String, Double)], Never>([(String, Double)]())
    
    var cancellable = Set<AnyCancellable>()
    
    private let searchManager: SearchManagerProtocol
    
    init(
        searchManager: SearchManagerProtocol
    ) {
        self.searchManager = searchManager
        setupViewModel()
    }
    
    
    func setupViewModel() {
        searchStringAndList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] itemData in
                var tempData = itemData
                var data = self?.searchManager.searchCurrencyCode(
                    str: tempData.0 ?? "",
                    arr: &tempData.1,
                    backupArr: tempData.1
                )
                guard let data = data else {return}
                self?.filteredList.send(data)
            }
            .store(in: &cancellable)
    }
}


