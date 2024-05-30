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
    
    var viewModel = CartViewModel()
    var productList = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cartTableView.dataSource = self
        cartTableView.delegate = self
        
        
        
        _ = viewModel.productList.subscribe(onNext: { products in
            self.productList = products
            DispatchQueue.main.async {
                self.cartTableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchProducts()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        viewModel.loadCart(username: "akn")
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
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(product.productImageName)"){
            DispatchQueue.main.async {
                cell.productImageView.kf.setImage(with: url)
            }
        }
        cell.productNameLabel.text = product.productName
        cell.productPriceLabel.text = "₺\(product.productPrice)"
        
        return cell
    }
    
    
}
