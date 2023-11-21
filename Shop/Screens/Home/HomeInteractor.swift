//
//  HomeInteractor.swift
//  Shop
//
//  Created by Juliano Terres on 19/11/23.
//

import Foundation

// MARK: HomeInteractor

final class HomeInteractor {
  // MARK: Private Properties
  
  private let presenter: HomePresenterProtocol
  private let service: HomeServiceProtocol
  private let router: HomeRouterProtocol
  private var products: [ProductApiModel] = []
  private var productsSizeSelecteds: [HomeProductSizeSelected] = []
  
  // MARK: Initialization
  
  init(
    presenter: HomePresenterProtocol,
    service: HomeServiceProtocol,
    router: HomeRouterProtocol
  ) {
    self.presenter = presenter
    self.service = service
    self.router = router
  }
}

// MARK: HomeInteractorProtocol

protocol HomeInteractorProtocol {
  func fetchProducts()
  func didTapCart()
  func didTapSize(row: Int, size: String)
}

extension HomeInteractor: HomeInteractorProtocol {
  func fetchProducts() {
    service.fetchProductsList { [weak self] response in
      switch response {
      case let .success(response):
        self?.didFetchProductsListSuccess(response: response)
      case .failure:
        self?.didFetchProductsListFailure()
      }
    }
  }
  
  func didTapCart() {
    router.navigation(screen: .cart)
  }
  
  func didTapSize(row: Int, size: String) {
    addSizeSelected(style: products[row].style, size: size)
    presenter.didSizeSelected(products: products, sizeSelecteds: productsSizeSelecteds)
  }
}

// MARK: Private Methods

private extension HomeInteractor {
  func didFetchProductsListSuccess(response: ProductsListApiResponse?) {
    guard let products = response?.products else { return }
    self.products = products
    presenter.didFetchSuccess(products: products)
  }
  
  func didFetchProductsListFailure() {
    presenter.didFetchError()
  }
  
  func addSizeSelected(style: String, size: String) {
    if sizeAlreadySelected(style: style, size: size) {
      deleteSizeSelected(style: style, size: size)
    }
    
    productsSizeSelecteds.append(
      HomeProductSizeSelected(
        size: size,
        style: style
      )
    )
  }
  
  func sizeAlreadySelected(style: String, size: String) -> Bool {
    productsSizeSelecteds.filter { $0.style == style }.count > 0
  }
  
  func deleteSizeSelected(style: String, size: String) {
    productsSizeSelecteds = productsSizeSelecteds.filter { $0.style != style }
  }
}
