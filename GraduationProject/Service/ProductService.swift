import Foundation
import RxSwift

class ProductService {
    var productList = BehaviorSubject<[Product]>(value: [Product]())
    var cartList = BehaviorSubject<[CartProduct]>(value: [CartProduct]())

    func addProductToCart(productName: String, productImageName: String, productPrice: Int, productAmount: Int, username: String) {
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "yemek_adi=\(productName)&yemek_resim_adi=\(productImageName)&yemek_fiyat=\(productPrice)&yemek_siparis_adet=\(productAmount)&kullanici_adi=\(username)"
        request.httpBody = postString.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let response = try JSONDecoder().decode(CRUDResponse.self, from: data!)
                print("Successful: \(response.success)")
                print("Message: \(response.message)")
            } catch {
                debugPrint(error.localizedDescription)
            }
        }.resume()
    }

    func delete(id: Int, username: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "sepet_yemek_id=\(id)&kullanici_adi=\(username)"
        request.httpBody = postString.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let response = try JSONDecoder().decode(CRUDResponse.self, from: data!)
                print("Successful: \(response.success)")
                print("Message: \(response.message)")
                completion(response.success == 1)
            } catch {
                debugPrint("DEBUG: delete \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
    }

    func fetchCart(username: String) {
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "kullanici_adi=\(username)"
        request.httpBody = postString.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let response = try JSONDecoder().decode(CartResponse.self, from: data!)
                debugPrint(response)
                if let list = response.products {
                    var mergedProducts = [String: CartProduct]()
                    for product in list {
                        if let existingProduct = mergedProducts[product.productName] {
                            // Eğer aynı isimde ürün varsa, miktarlarını topluyoruz
                            let newAmount = (Int(existingProduct.productAmount)! + Int(product.productAmount)!)
                            var updatedProduct = existingProduct
                            updatedProduct.productAmount = String(newAmount)
                            mergedProducts[product.productName] = updatedProduct
                        } else {
                            // Eğer ürün ilk kez ekleniyorsa, direkt ekliyoruz
                            mergedProducts[product.productName] = product
                        }
                    }
                    // Birleştirilmiş ürünleri listeye çeviriyoruz
                    let finalList = Array(mergedProducts.values)
                    self.cartList.onNext(finalList)
                }
            } catch {
                debugPrint("DEBUG: fetch \(error.localizedDescription)")
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
                debugPrint(error.localizedDescription)
            }
        }.resume()
    }
}
