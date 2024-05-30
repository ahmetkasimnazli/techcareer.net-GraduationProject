//
//  FavoriteProductsViewModel.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 30.05.2024.
//

import Foundation
import RxSwift

class FavoriteProductsViewModel {
    var productService = ProductService()
    var productList = BehaviorSubject<[Product]>(value: [Product]())
    
    init() {
        productList = productService.productList
    }
    
    func loadProducts() {
        productService.fetchProducts()
    }
}
