//
//  ViewController.swift
//  GraduationProject
//
//  Created by Ahmet Kasım Nazlı on 23.05.2024.
//

import UIKit

class ProductsViewController: UIViewController {
    @IBOutlet var productsCollectionView: UICollectionView!
    var productList = [Product]()
    var viewModel = ProductsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        configureCollectionViewDesign()
        
        _ = viewModel.productList.subscribe(onNext: { products in
            self.productList = products
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchProducts()
    }
    
    func configureCollectionViewDesign() {
        let design = UICollectionViewFlowLayout()
        
        design.sectionInset = UIEdgeInsets(top: 5, left: 26, bottom: 26, right: 26)
        design.minimumInteritemSpacing = 20
        design.minimumLineSpacing = 20
        
        // 10 X 10 X 10 = 30
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 72) / 2
        
        design.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.1)
        
        productsCollectionView.collectionViewLayout = design
    }

    @IBAction func orderButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Listing order", message: "Select a listing option!", preferredStyle: .actionSheet)
        let priceAscAction = UIAlertAction(title: "Price - Ascending", style: .default) { _ in
            print("Price - Asc button tapped!")
        }
        let priceDescAction = UIAlertAction(title: "Price - Descending", style: .default) { _ in
            print("Price - Desc button tapped!")
        }
        alertController.addAction(priceAscAction)
        alertController.addAction(priceDescAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductsCollectionViewCell
        let product = productList[indexPath.row]
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(product.productImageName)"){
                DispatchQueue.main.async {
                    cell.productImage.kf.setImage(with: url)
                }
            }
        cell.productNameLabel.text = product.productName
        cell.productPriceLabel.text = "₺\(product.productPrice)"
        
        cell.layer.cornerRadius = 15.0
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.1
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: product)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let product = sender as? Product {
                let destinationVC = segue.destination as! ProductDetailViewController
                destinationVC.product = product
            }
        }
    }
}

