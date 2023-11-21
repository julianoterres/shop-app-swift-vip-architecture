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
      router: router
    )
    
    let homeView = HomeView()
    
    let viewController = HomeViewController(
      screenView: homeView,
      interactor: interactor
    )
    
    presenter.viewController = viewController
    router.viewController = viewController
    
    return viewController
  }
}
