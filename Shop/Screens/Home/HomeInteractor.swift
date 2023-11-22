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
  private let cart: CartManagerProtocol
  private var products: [ProductApiModel] = []
  private var productsSizeSelecteds: [HomeProductSizeSelected] = []
  
  // MARK: Initialization
  
  init(
    presenter: HomePresenterProtocol,
    service: HomeServiceProtocol,
    router: HomeRouterProtocol,
    cart: CartManagerProtocol
  ) {
    self.presenter = presenter
    self.service = service
    self.router = router
    self.cart = cart
  }
}

// MARK: HomeInteractorProtocol

protocol HomeInteractorProtocol {
  func fetchProducts()
  func didTapCart()
  func didTapSize(sku: String)
  func didTapAddCart(indexPath: IndexPath?)
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
  
  func didTapAddCart(indexPath: IndexPath?) {
    guard let row = indexPath?.row,
          let data = getProductSelected(row: row) else {
      presenter.didProductAddCartFailure()
      return
    }
    
    addProductCart(product: data.product, sku: data.producSize.sku ,size: data.producSize.size)
    deleteSizeSelected(size: data.producSize)
    
    presenter.didProductAddCartSucccess()
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
    presenter.didFetchFailure()
  }
  
  func addSizeSelected(sku: String) {
    guard let size = getSizeProduct(sku: sku) else {
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
  
  func getSizeProduct(sku: String) -> ProductSizeApiModel? {
    products.first(where: { $0.sizes.contains(where: { $0.sku == sku }) })?.sizes.first(where: { $0.sku == sku })
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
  
  func getProductSelected(row: Int) -> (product: ProductApiModel, producSize: ProductSizeApiModel)? {
    let product = products[row]
    
    guard let size = product.sizes.first else {
      return nil
    }
    
    let skuWihtoutSize = getSkuWhithoutSize(size: size)
    
    guard let sizeSelected = productsSizeSelecteds.first(where: { $0.sku.contains(skuWihtoutSize) }),
          let productSize = product.sizes.first(where: { $0.sku == sizeSelected.sku }) else {
      return nil
    }
    
    return (product, productSize)
  }
  
  func addProductCart(product: ProductApiModel, sku: String, size: String) {
    let product = CartProductsModel(
      sku: sku,
      name: product.name,
      image: product.image,
      size: size,
      price: product.actualPrice
    )
    
    cart.add(product: product)
  }
}
