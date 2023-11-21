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
  func didFetchProductsSuccess(products: [CartProductsModel])
}

extension CartPresenter: CartPresenterProtocol {
  func didFetchProductsSuccess(products: [CartProductsModel]) {
    let products = products.map {
      CartProductListCellViewModel(
        image: URL(string: $0.image),
        name: $0.name,
        price: "Preço: \($0.price)",
        size: "Tamanho: \($0.size)",
        qty: "Quantidade: 1"
      )
    }
    
    viewController?.present(products: products)
  }
}
