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
  
}

extension CartInteractor: CartInteractorProtocol {
}
