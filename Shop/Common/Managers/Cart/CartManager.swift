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
  private var products: [CartProductsModel] = []
  
  // MARK: Inititalization
  
  init(session: SessionManagerProtocol = SessionManager()) {
    self.session = session
  }
}

// MARK: CartManagerProtocol

protocol CartManagerProtocol {
  func add(product: CartProductsModel)
}

extension CartManager: CartManagerProtocol {
  func add(product: CartProductsModel) {
    guard productAlreadyAddCart(product: product) == false else {
      return
    }
    
    var productsCart = getProductsCart()
    productsCart.append(product)
    
    session.save(value: productsCart, key: .cart)
  }
}

// MARK: Private Methods

private extension CartManager {
  func productAlreadyAddCart(product: CartProductsModel) -> Bool {
    let productsCart = getProductsCart()
    
    return productsCart.contains(where: { $0 == product })
  }
  
  func getProductsCart() -> [CartProductsModel] {
    session.get(dataType: [CartProductsModel].self, key: .cart) ?? []
  }
}
