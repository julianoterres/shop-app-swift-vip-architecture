//
//  CartFactory.swift
//  Shop
//
//  Created by Juliano Terres on 21/11/23.
//

import UIKit

// MARK: CartFactory

final class CartFactory {
  static func create() -> UIViewController {
    let cart = CartManager()
    
    let presenter = CartPresenter()
      
    let interactor = CartInteractor(
      presenter: presenter,
      cart: cart
    )
    
    let view = CartView()
    
    let viewController = CartViewController(
      screenView: view,
      interactor: interactor
    )
    
    presenter.viewController = viewController
    
    return viewController
  }
}

