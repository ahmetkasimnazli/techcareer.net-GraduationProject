//
//  ProductDetailViewController.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 23.05.2024.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var addToFavoriteButton: UIButton!
    
    @IBOutlet var unitStepper: UIStepper!
    @IBOutlet var unitStepperLabel: UILabel!
    
    var isAddToFavoriteButtonActive: Bool = false
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    

    func configureUI() {
        if let product = product {
            productImageView.image = UIImage(named: product.productImage)
            productNameLabel.text = product.productName
            unitStepperLabel.text = String(Int(unitStepper.value))
        }
    }
    
    @IBAction func addToFavoriteButtonTapped(_ sender: Any) {
        if isAddToFavoriteButtonActive {
            isAddToFavoriteButtonActive.toggle()
            addToFavoriteButton.tintColor = .lightGray
        }
        else {
            isAddToFavoriteButtonActive.toggle()
            addToFavoriteButton.tintColor = UIColor(named: "mainColor")
        }
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        
    }
    @IBAction func unitStepperTapped(_ sender: Any) {
        unitStepperLabel.text = String(Int(unitStepper.value))
    }
    
}
