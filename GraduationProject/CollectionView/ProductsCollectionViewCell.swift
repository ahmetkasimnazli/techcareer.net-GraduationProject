//
//  CollectionViewCell.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 23.05.2024.
//

import UIKit

protocol CellProtocol {
    func addToCartTapped(indexPath: IndexPath)
}

class ProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!

    var cellProtocol: CellProtocol?
    var indexPath: IndexPath?

    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        cellProtocol?.addToCartTapped(indexPath: indexPath!)
    }
    
}
