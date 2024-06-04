//
//  CartProduct.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 1.06.2024.
//

import Foundation

struct CartProduct: Codable {
    var id: String
    var productName: String
    var productPrice: String
    var productAmount: String
    var productImageName: String
    var username: String
    
    enum CodingKeys: String, CodingKey {
            case id = "sepet_yemek_id"
            case productName = "yemek_adi"
            case productPrice = "yemek_fiyat"
            case productAmount = "yemek_siparis_adet"
            case productImageName = "yemek_resim_adi"
            case username = "kullanici_adi"
        }
}
