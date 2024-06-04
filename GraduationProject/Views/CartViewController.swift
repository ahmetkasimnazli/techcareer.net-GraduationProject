import UIKit

class CartViewController: UIViewController {
    @IBOutlet var adressLabel: UILabel!
    @IBOutlet var cartTableView: UITableView!
    @IBOutlet var deliveryFeeLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!

    var viewModel = CartViewModel()
    var cartList = [CartProduct]()

    override func viewDidLoad() {
        super.viewDidLoad()

        cartTableView.dataSource = self
        cartTableView.delegate = self

        _ = viewModel.cartList.subscribe(onNext: { products in
            self.cartList = products
            DispatchQueue.main.async {
                self.cartTableView.reloadData()
                self.updateTotal()
            }
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCart(username: "akn")
    }

    @IBAction func adressEditButtonTapped(_ sender: Any) {}

    @IBAction func checkoutButtonTapped(_ sender: Any) {}
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        let product = cartList[indexPath.row]

        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(product.productImageName)") {
            DispatchQueue.main.async {
                cell.productImageView.kf.setImage(with: url)
            }
        }
        cell.productNameLabel.text = product.productName
        cell.productPriceLabel.text = "₺\(product.productPrice)"
        cell.productUnitLabel.text = "x\(product.productAmount)"
        cell.productTotalLabel.text = "₺\(Int(product.productPrice)! * Int(product.productAmount)!)"

        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, bool in
            let product = self.cartList[indexPath.row]

            let alert = UIAlertController(title: "Delete Action", message: "Do you want to remove \(product.productName) from your cart?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.viewModel.delete(id: Int(product.id)!, username: "akn") { success in
                    if success {
                        // UI'de değişiklik yaparak ürünü kaldır
                        DispatchQueue.main.async {
                            self.cartList.remove(at: indexPath.row)
                            self.cartTableView.deleteRows(at: [indexPath], with: .automatic)
                            self.updateTotal()
                        }
                    }
                }
            }
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)

            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func updateTotal() {
        var total = 10
        for product in cartList {
            if let productPrice = Int(product.productPrice), let productAmount = Int(product.productAmount) {
                total += productPrice * productAmount
            }
        }
        totalLabel.text = "₺\(total)"
    }
}
