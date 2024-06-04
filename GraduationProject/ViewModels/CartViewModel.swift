import Foundation
import RxSwift

class CartViewModel {
    var productService = ProductService()
    var cartList = BehaviorSubject<[CartProduct]>(value: [CartProduct]())

    init() {
        cartList = productService.cartList
    }

    func delete(id: Int, username: String, completion: @escaping (Bool) -> Void) {
        productService.delete(id: id, username: username) { success in
            if success {
                self.fetchCart(username: "akn")
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    func fetchCart(username: String) {
        productService.fetchCart(username: username)
    }
}
