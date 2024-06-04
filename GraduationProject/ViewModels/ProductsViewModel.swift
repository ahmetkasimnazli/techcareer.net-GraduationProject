//
//  ProductsViewModel.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 30.05.2024.
//

import Foundation
import RxSwift

class ProductsViewModel {
    var productService = ProductService()
    var productList = BehaviorSubject<[Product]>(value: [Product]())

    init() {
        productList = productService.productList
    }

    func fetchProducts() {
        productService.fetchProducts()
    }

    func addProductToCart(productName: String, productImageName: String, productPrice: Int, productAmount: Int, username: String ) {
        productService.addProductToCart(productName: productName, productImageName: productImageName, productPrice: productPrice, productAmount: productAmount, username: username)
    }

    func sortProductsByPriceAscending() {
        if let products = try? productList.value() {
            let sortedProducts = products.sorted { Int($0.productPrice)! < Int($1.productPrice)! }
            productList.onNext(sortedProducts)
        }
    }

    func sortProductsByPriceDescending() {
        if let products = try? productList.value() {
            let sortedProducts = products.sorted { Int($0.productPrice)! > Int($1.productPrice)! }
            productList.onNext(sortedProducts)
        }
    }
}
