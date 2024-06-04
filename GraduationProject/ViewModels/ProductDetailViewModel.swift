//
//  ProductDetailViewModel.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 30.05.2024.
//

import Foundation
import RxSwift

class ProductDetailViewModel {
    var productService = ProductService()
    
    func addProductToCart(productName: String, productImageName: String, productPrice: Int, productAmount: Int, username: String ) {
        productService.addProductToCart(productName: productName, productImageName: productImageName, productPrice: productPrice, productAmount: productAmount, username: username)
    }
}
