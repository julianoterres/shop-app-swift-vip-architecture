//
//  HomeRouter.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import UIKit

// MARK: HomeRouter

final class HomeRouter {
  // MARK: Public Properties
  
  var viewController: UIViewController?
  
  // MARK: Screens
  
  enum Screens {
    case cart
  }
}

// MARK: HomeRouter

protocol HomeRouterProtocol {
  func navigation(screen: HomeRouter.Screens)
}

extension HomeRouter: HomeRouterProtocol {
  func navigation(screen: HomeRouter.Screens) {
    switch screen {
    case .cart:
      navigationToCart()
    }
  }
}

// MARK: Private Methods

private extension HomeRouter {
  func navigationToCart() {
    let cartScreen = CartFactory.create()
    viewController?.navigationController?.pushViewController(cartScreen, animated: true)
  }
}
