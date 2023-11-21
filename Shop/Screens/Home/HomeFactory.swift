//
//  HomeFactory.swift
//  Shop
//
//  Created by Juliano Terres on 19/11/23.
//

import UIKit

// MARK: HomeFactory

final class HomeFactory {
  static func create() -> UIViewController {
    let network = NetworkManager()
    
    let cart = CartManager()
    
    let presenter = HomePresenter()
      
    let productsService = ProductsService(
      network: network
    )
    
    let service = HomeService(
      productsService: productsService
    )
    
    let router = HomeRouter()
    
    let interactor = HomeInteractor(
      presenter: presenter,
      service: service,
      router: router,
      cart: cart
    )
    
    let view = HomeView()
    
    let viewController = HomeViewController(
      screenView: view,
      interactor: interactor
    )
    
    presenter.viewController = viewController
    router.viewController = viewController
    
    return viewController
  }
}
