//
//  CountryListViewController.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/18/23.
//

import UIKit

class CountryListViewController: UIViewController {
    @IBOutlet weak var countryList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
