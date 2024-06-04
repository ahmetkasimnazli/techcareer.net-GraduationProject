//
//  CartResponse.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 30.05.2024.
//

import Foundation

struct CartResponse: Codable {
    var products: [CartProduct]?
    var success: Int
    
    enum CodingKeys: String, CodingKey {
        case products = "sepet_yemekler"
        case success = "success"
    }
}
