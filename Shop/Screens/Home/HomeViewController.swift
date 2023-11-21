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
    setupDelegates()
    interactor.fetchProducts()
  }
  
  override func loadView() {
    view = screenView
  }
}

// MARK: HomePresenterProtocol

protocol HomeViewControllerProtocol: AnyObject {
  func present(products: [ProductListCellViewModel])
  func present(error: String)
}

extension HomeViewController: HomeViewControllerProtocol {
  func present(products: [ProductListCellViewModel]) {
    self.products = products
    screenView.reloadProducts()
  }
  
  func present(error: String) {}
}

// MARK: Private Methods

private extension HomeViewController {
  func setup() {
    title = "Produtos"
  }
  
  func setupDelegates() {
    screenView.setupCollection(delegate: self)
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
    return cell
  }
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  }
}
