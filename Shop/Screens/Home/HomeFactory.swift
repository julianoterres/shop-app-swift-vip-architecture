//
//  HomeFactory.swift
//  Shop
//
//  Created by Juliano Terres on 19/11/23.
//

import UIKit

final class HomeFactory {
  static func create() -> UIViewController {
    
    let presenter = HomePresenter(
      
    )
    
    let interactor = HomeInteractor(
      presenter: presenter
    )
    
    let viewController = HomeViewController(
      interactor: interactor
    )
    
    presenter.viewController = viewController
    
    return viewController
  }
}
