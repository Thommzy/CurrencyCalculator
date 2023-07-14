//
//  HomeViewController.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/13/23.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var currencyOneView: PrimaryTextFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
}
