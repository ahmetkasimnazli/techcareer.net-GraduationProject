//
//  FavoritesTableViewCell.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 28.05.2024.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
