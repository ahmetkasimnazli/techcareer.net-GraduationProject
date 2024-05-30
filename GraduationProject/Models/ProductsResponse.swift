//
//  ProductsResponse.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 30.05.2024.
//

import Foundation

struct ProductsResponse: Codable {
    var products: [Product]?
    var success: Int?
    
    enum CodingKeys: String, CodingKey {
        case products = "yemekler"
        case success = "success"
    }
}
