//
//  HomeViewController.swift
//  Shop
//
//  Created by Juliano Terres on 19/11/23.
//

import UIKit

// MARK: HomeViewController

final class HomeViewController: UIViewController {
  // MARK: Private Properties
  
  private let interactor: HomeInteractorProtocol
  private let screenView: HomeViewProtocol
  private var products: [ProductListCellViewModel] = []
  
  // MARK: Inicialization

  init(
    screenView: HomeViewProtocol,
    interactor: HomeInteractorProtocol
  ) {
    self.screenView = screenView
    self.interactor = interactor
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    interactor.fetchProducts()
  }
  
  override func loadView() {
    view = screenView
  }
}

// MARK: HomePresenterProtocol

protocol HomeViewControllerProtocol: AnyObject {
  func present(products: [ProductListCellViewModel])
  func present(title: String, message: String)
}

extension HomeViewController: HomeViewControllerProtocol {
  func present(products: [ProductListCellViewModel]) {
    self.products = products
    screenView.reloadProducts()
  }
  
  func present(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

// MARK: Private Methods

private extension HomeViewController {
  func setup() {
    setupTitle()
    addCardButtonInNavigation()
    setupDelegates()
  }
  
  func setupTitle() {
    title = "Produtos"
  }
  
  func setupDelegates() {
    screenView.setupCollection(delegate: self)
  }
  
  func addCardButtonInNavigation() {
    let button = UIBarButtonItem(
      title: "Carrinho",
      image: nil,
      target: self,
      action: #selector(didTapCart)
    )
    
    navigationItem.rightBarButtonItem = button
  }
    
  @objc func didTapCart() {
    interactor.didTapCart()
  }
}

// MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    return products.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: ProductListCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
    cell.viewModel = products[indexPath.row]
    cell.delegate = self
    return cell
  }
}

// MARK: ProductListCellDelegate

extension HomeViewController: ProductListCellDelegate {
  func didTapSize(sku:  String) {
    interactor.didTapSize(sku: sku)
  }
  
  func didTapAddCart(indexPath: IndexPath?) {
    interactor.didTapAddCart(indexPath: indexPath)
  }
}
