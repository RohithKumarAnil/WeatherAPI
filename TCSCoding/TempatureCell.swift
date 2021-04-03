//
//  TempatureCell.swift
//  TCSCoding
//
//  Created by Rohith Kumar on 4/2/21.
//

import Foundation
import UIKit

class TempatureCell: UITableViewCell {
    
    @IBOutlet weak var descritionLabel : UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    
    func updateCellData(with model: DetailsOfCity, forIndexPath: IndexPath) {        
        descritionLabel.text = model.rows[forIndexPath.row].label
        valueLabel.text = model.rows[forIndexPath.row].value
    }
}
