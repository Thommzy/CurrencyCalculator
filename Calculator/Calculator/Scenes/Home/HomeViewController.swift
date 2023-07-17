//
//  HomeViewController.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/13/23.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var currencyOneView: PrimaryTextFieldView!
    @IBOutlet weak var currencyOne: CurrencyButtonView!
    @IBOutlet weak var currencyTwo: CurrencyButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupActions()
    }
    
    @IBAction func convertBtnAction(_ sender: UIButton) {
        debugPrint("convertBtnAction-->>")
    }
}

extension HomeViewController {
    func setupActions() {
        currencyOne.onTap = {
            debugPrint("currencyOne--->>>")
        }
        
        currencyTwo.onTap = {
            debugPrint("currencyTwo--->>>")
        }
    }
}
