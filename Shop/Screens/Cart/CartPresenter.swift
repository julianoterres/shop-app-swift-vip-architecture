//
//  CartPresenter.swift
//  Shop
//
//  Created by Juliano Terres on 21/11/23.
//

import Foundation

// MARK: CartPresenter

final class CartPresenter {
  // MARK: Public Properties
  
  weak var viewController: CartViewControllerProtocol?
}

// MARK: CartPresenterProtocol

protocol CartPresenterProtocol {
}

extension CartPresenter: CartPresenterProtocol {
}
