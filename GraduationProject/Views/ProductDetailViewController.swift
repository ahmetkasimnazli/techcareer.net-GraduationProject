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
    var viewModel = ProductDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        if let product = product {
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(product.productImageName)"){
                    DispatchQueue.main.async {
                        self.productImageView.kf.setImage(with: url)
                    }
                }
            productNameLabel.text = product.productName
            productPriceLabel.text = "₺\(product.productPrice)"
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
        guard let product = product else {
            print("DEBUG: 1")
            return}
        viewModel.addProductToCart(productName: product.productName, productPrice: Int(product.productPrice)! , productAmount: Int(unitStepper.value), username: "akn")
        
    }
    @IBAction func unitStepperTapped(_ sender: Any) {
        unitStepperLabel.text = String(Int(unitStepper.value))
    }
    
}
