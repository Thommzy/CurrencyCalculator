//
//  CountryTableViewCell.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/18/23.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyCodeCode: UILabel!
    @IBOutlet weak var currencyRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var data: (String, Double)? {
        didSet {
            if let data = data {
                currencyCodeCode.text = data.0
                currencyRate.text = "\(data.1)"
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
