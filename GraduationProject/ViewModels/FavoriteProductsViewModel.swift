import Foundation
import RxSwift

class FavoriteProductsViewModel {
    var productList = BehaviorSubject<[Product]>(value: [Product]())

    init() {
        loadFavorites()
    }

    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favoriteProducts") {
            let favorites = try? JSONDecoder().decode([Product].self, from: data)
            productList.onNext(favorites ?? [])
        }
    }

    func addFavorite(product: Product) {
        var currentFavorites = try? productList.value()
        currentFavorites?.append(product)
        saveFavorites(products: currentFavorites ?? [])
    }

    func removeFavorite(product: Product) {
        var currentFavorites = try? productList.value()
        currentFavorites = currentFavorites?.filter { $0.productName != product.productName }
        saveFavorites(products: currentFavorites ?? [])
    }

    private func saveFavorites(products: [Product]) {
        if let data = try? JSONEncoder().encode(products) {
            UserDefaults.standard.set(data, forKey: "favoriteProducts")
            productList.onNext(products)
        }
    }

    func isFavorite(product: Product) -> Bool {
        let currentFavorites = try? productList.value()
        return currentFavorites?.contains(where: { $0.productName == product.productName }) ?? false
    }
}
