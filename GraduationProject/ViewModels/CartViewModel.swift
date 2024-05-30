//
//  CartViewModel.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 30.05.2024.
//

import Foundation
import RxSwift

class CartViewModel {
    var productService = ProductService()
    var productList = BehaviorSubject<[Product]>(value: [Product]())
    
    init() {
        productList = productService.productList
    }
    func fetchProducts(){
        productService.fetchProducts()
    }
    
    func loadCart(username: String){
        productService.loadCart(username: username)
    }

}
