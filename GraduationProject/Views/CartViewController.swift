//
//  CartViewController.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 28.05.2024.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet var adressLabel: UILabel!
    @IBOutlet var cartTableView: UITableView!
    @IBOutlet var deliveryFeeLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    let productList: [Product] = [
    Product(id: 1, productName: "Fanta", productPrice: 2.25, productImage: "fanta.png"),
    Product(id: 2, productName: "Ayran", productPrice: 1.25, productImage: "ayran.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cartTableView.dataSource = self
        cartTableView.delegate = self
    }

    @IBAction func adressEditButtonTapped(_ sender: Any) {
        
    }
    @IBAction func checkoutButtonTapped(_ sender: Any) {
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        let product = productList[indexPath.row]
        
        cell.productImageView.image = UIImage(named: product.productImage)
        cell.productNameLabel.text = product.productName
        cell.productPriceLabel.text = "$\(product.productPrice)"
        
        return cell
    }
    
    
}
