//
//  CartTableViewCell.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 28.05.2024.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productUnitLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productTotalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
