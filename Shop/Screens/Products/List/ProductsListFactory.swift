//
//  ProductsListFactory.swift
//  Shop
//
//  Created by Juliano Terres on 19/11/23.
//

import UIKit

final class ProductsListFactory {
  static func create() -> UIViewController {
    let view = UIViewController()
    view.view.backgroundColor = .red
    return view
  }
}
