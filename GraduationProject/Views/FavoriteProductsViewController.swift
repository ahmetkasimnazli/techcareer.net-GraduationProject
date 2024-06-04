//
//  FavoriteProductsViewController.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 28.05.2024.
//

import UIKit
import Kingfisher
import RxSwift

class FavoriteProductsViewController: UIViewController {
    @IBOutlet var favoritesTableView: UITableView!
    
    var viewModel = FavoriteProductsViewModel()
    var disposeBag = DisposeBag()
    var productList: [Product] = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self

        viewModel.productList
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { products in
                        self.productList = products
                        self.favoritesTableView.reloadData()
                    })
                    .disposed(by: disposeBag)
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
        cell.productPriceLabel.text = "₺\(product.productPrice)"

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let product = productList[indexPath.row]
                viewModel.removeFavorite(product: product)
            }
        }

        func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
            return "Remove"
        }
}
