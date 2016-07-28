//
//  CityTableViewCell.swift
//  TableViewExampe
//
//  Created by Karan Singhal on 7/25/16.
//  Copyright © 2016 Harvard University. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
