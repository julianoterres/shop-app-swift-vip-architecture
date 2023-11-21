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
  func didTapSize(sku: String)
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
  
  func didTapSize(sku: String) {
    addSizeSelected(sku: sku)
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
  
  func addSizeSelected(sku: String) {
    guard let size = products.first(where: { $0.sizes.contains(where: { $0.sku == sku }) })?.sizes.first(where: { $0.sku == sku }) else {
      return
    }
    
    if sizeAlreadySelected(size: size) {
      deleteSizeSelected(size: size)
    }
    
    productsSizeSelecteds.append(
      HomeProductSizeSelected(
        sku: sku
      )
    )
  }
  
  func sizeAlreadySelected(size: ProductSizeApiModel) -> Bool {
    let skuWhithoutSize = getSkuWhithoutSize(size: size)
    
    return productsSizeSelecteds.contains(where: { $0.sku.contains(skuWhithoutSize) })
  }
  
  func deleteSizeSelected(size: ProductSizeApiModel) {
    let skuWhithoutSize = getSkuWhithoutSize(size: size)
    
    productsSizeSelecteds = productsSizeSelecteds.filter {
      $0.sku.notContains(skuWhithoutSize)
    }
  }
  
  func getSkuWhithoutSize(size: ProductSizeApiModel) -> String {
    size.sku.replacingOccurrences(of: size.size, with: "")
  }
}
