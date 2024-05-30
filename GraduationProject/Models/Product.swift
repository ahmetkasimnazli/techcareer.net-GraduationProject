//
//  Product.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 23.05.2024.
//

import Foundation

struct Product: Codable {
    var id: String
    var productName: String
    var productPrice: String
    var productImageName: String
    
    enum CodingKeys: String, CodingKey {
            case id = "yemek_id"
            case productName = "yemek_adi"
            case productPrice = "yemek_fiyat"
            case productImageName = "yemek_resim_adi"
        }
}
