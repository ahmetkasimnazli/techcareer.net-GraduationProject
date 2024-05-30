//
//  ProductService.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 30.05.2024.
//

import Foundation
import RxSwift

class ProductService {
    var productList = BehaviorSubject<[Product]>(value: [Product]())
    
    func addProductToCart(productName: String, productPrice: Int, productAmount: Int, username: String ) {
        print("DEBUG: \(productName), \(productPrice), \(productAmount), \(username))")
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "yemek_adi=\(productName)&yemek_resim_adi=\(productName).png&yemek_fiyat=\(productPrice)&yemek_siparis_adet=\(productAmount)&kullanici_adi=\(username)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                let response = try JSONDecoder().decode(CRUDResponse.self, from: data!)
                print("Successful: \(response.success)")
                print("Message: \(response.message)")
                
            }catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func loadCart(username: String){
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "kullanici_adi=\(username)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                let response = try JSONDecoder().decode(CartResponse.self, from: data!)
                if let list = response.products {
                    self.productList.onNext(list)
                }
            }catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchProducts() {
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let response = try JSONDecoder().decode(ProductsResponse.self, from: data!)
                    if let list = response.products {
                        self.productList.onNext(list)
                    }
                
            } catch {
                print("DEBUG:\(response),  \(error)")
            }
        }.resume()
    }
    
    
    
}
