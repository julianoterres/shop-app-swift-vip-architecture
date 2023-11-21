//
//  CartViewController.swift
//  Shop
//
//  Created by Juliano Terres on 21/11/23.
//

import UIKit

// MARK: CartViewController

final class CartViewController: UIViewController {
  // MARK: Private Properties
  
  private let interactor: CartInteractorProtocol
  private let screenView: CartViewProtocol
  private var products: [CartProductListCellViewModel] = []
  
  // MARK: Inicialization

  init(
    screenView: CartViewProtocol,
    interactor: CartInteractorProtocol
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

// MARK: CartPresenterProtocol

protocol CartViewControllerProtocol: AnyObject {
  func present(products: [CartProductListCellViewModel])
}

extension CartViewController: CartViewControllerProtocol {
  func present(products: [CartProductListCellViewModel]) {
    self.products = products
    screenView.reloadProducts()
  }
}

// MARK: Private Methods

private extension CartViewController {
  func setup() {
    setupTitle()
    setupDelegates()
  }
  
  func setupTitle() {
    title = "Carrinho"
  }
  
  func setupDelegates() {
    screenView.setupCollection(delegate: self)
  }
}

// MARK: UICollectionViewDataSource

extension CartViewController: UICollectionViewDataSource {
  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    return products.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CartProductListCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
    cell.viewModel = products[indexPath.row]
    cell.delegate = self
    return cell
  }
}

// MARK: CartProductListCellDelegate

extension CartViewController: CartProductListCellDelegate {
  func didTapRemove(indexPath: IndexPath?) {
    interactor.didTapRemove(indexPath: indexPath)
  }
}
