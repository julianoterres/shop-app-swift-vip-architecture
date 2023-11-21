//
//  CartManager.swift
//  Shop
//
//  Created by Juliano Terres on 21/11/23.
//

import Foundation

// MARK: CartManager

final class CartManager {
  // MARK: Private Properties
  
  private let session: SessionManagerProtocol
  
  // MARK: Inititalization
  
  init(session: SessionManagerProtocol = SessionManager()) {
    self.session = session
  }
}

// MARK: CartManagerProtocol

protocol CartManagerProtocol {
  func add(product: CartProductsModel)
  func remove(product: CartProductsModel)
  func getProducts() -> [CartProductsModel]
}

extension CartManager: CartManagerProtocol {
  func add(product: CartProductsModel) {
    guard productAlreadyAddCart(product: product) == false else {
      return
    }
    
    var productsCart = getProducts()
    productsCart.append(product)
    
    session.save(value: productsCart, key: .cart)
  }
  
  func getProducts() -> [CartProductsModel] {
    session.get(dataType: [CartProductsModel].self, key: .cart) ?? []
  }
  
  func remove(product: CartProductsModel) {
    let allProducts = getProducts()
    let allProductsNew = allProducts.filter { $0 != product }
    
    session.save(value: allProductsNew, key: .cart)
  }
}

// MARK: Private Methods

private extension CartManager {
  func productAlreadyAddCart(product: CartProductsModel) -> Bool {
    let products = getProducts()
    return products.contains(where: { $0 == product })
  }
}
