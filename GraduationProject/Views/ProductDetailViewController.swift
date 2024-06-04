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
    var favoriteViewModel = FavoriteProductsViewModel()

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

            isAddToFavoriteButtonActive = favoriteViewModel.isFavorite(product: product)
                        updateFavoriteButton()
        }
    }
    
    @IBAction func addToFavoriteButtonTapped(_ sender: Any) {
        guard let product = product else { return }
                if isAddToFavoriteButtonActive {
                    favoriteViewModel.removeFavorite(product: product)
                } else {
                    favoriteViewModel.addFavorite(product: product)
                }
                isAddToFavoriteButtonActive.toggle()
                updateFavoriteButton()
    }
    
    func updateFavoriteButton() {
        let buttonColor = isAddToFavoriteButtonActive ? UIColor(named: "mainColor") : .lightGray
        addToFavoriteButton.tintColor = buttonColor
    }

    @IBAction func addToCartButtonTapped(_ sender: Any) {
        guard let product = product else {
            print("DEBUG: 1")
            return}
        viewModel.addProductToCart(productName: product.productName, productImageName: product.productImageName, productPrice: Int(product.productPrice)! , productAmount: Int(unitStepper.value), username: "akn")
        
    }
    @IBAction func unitStepperTapped(_ sender: Any) {
        unitStepperLabel.text = String(Int(unitStepper.value))
    }
    
}
