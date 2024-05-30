//
//  CartResponse.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 30.05.2024.
//

import Foundation

struct CartResponse: Codable {
    var products: [Product]?
    var success: Int
}
