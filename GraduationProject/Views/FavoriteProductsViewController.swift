//
//  FavoriteProductsViewController.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 28.05.2024.
//

import UIKit
import Kingfisher

class FavoriteProductsViewController: UIViewController {
    @IBOutlet var favoritesTableView: UITableView!
    
    let productList: [Product] = [
    Product(id: "1", productName: "Fanta", productPrice: "2", productImageName: "fanta.png"),
    Product(id: "2", productName: "Ayran", productPrice: "1", productImageName: "ayran.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
}

extension FavoriteProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesTableViewCell
        let product = productList[indexPath.row]
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(product.productImageName)"){
                DispatchQueue.main.async {
                    cell.productImageView.kf.setImage(with: url)
                }
            }
        cell.productNameLabel.text = product.productName
        cell.productPriceLabel.text = "$\(product.productPrice)"
        
        return cell
    }
}
