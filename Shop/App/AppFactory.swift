//
//  AppFactory.swift
//  Shop
//
//  Created by Juliano Terres on 19/11/23.
//

import UIKit

class AppFactory {
  static func create() -> UIViewController {
    let navigation = UINavigationController()
    let startScreen = HomeFactory.create()
    
    navigation.viewControllers = [startScreen]
    
    return navigation
  }  
}
