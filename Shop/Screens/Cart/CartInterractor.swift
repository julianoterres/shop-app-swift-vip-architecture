//
//  CartInteractor.swift
//  Shop
//
//  Created by Juliano Terres on 21/11/23.
//

import Foundation

// MARK: CartInteractor

final class CartInteractor {
  // MARK: Private Properties
  
  private let presenter: CartPresenterProtocol
  private let cart: CartManagerProtocol
  private var products: [CartProductsModel] = []
  
  // MARK: Initialization
  
  init(
    presenter: CartPresenterProtocol,
    cart: CartManagerProtocol
  ) {
    self.presenter = presenter
    self.cart = cart
  }
}

// MARK: CartInteractorProtocol

protocol CartInteractorProtocol {
  func fetchProducts()
  func didTapRemove(indexPath: IndexPath?)
}

extension CartInteractor: CartInteractorProtocol {
  func fetchProducts() {
    products = cart.getProducts()
    presenter.didFetchProductsSuccess(products: products)
  }
  
  func didTapRemove(indexPath: IndexPath?) {
    guard let row = indexPath?.row else { return }
    let product = products[row]
    
    cart.remove(product: product)
    fetchProducts()
  }
}
