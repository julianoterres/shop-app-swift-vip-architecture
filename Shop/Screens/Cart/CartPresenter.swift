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
    presentProducts(products: products)
    presentTotal(products: products)
  }
}

// MARK: Private Methods

private extension CartPresenter {
  func presentProducts(products: [CartProductsModel]) {
    let products = products.map {
      CartProductListCellViewModel(
        image: URL(string: $0.image),
        name: $0.name,
        price: $0.price.fortmatToCurrency,
        size: "Tamanho: \($0.size)",
        qty: "Quantidade: 1"
      )
    }
    
    viewController?.present(products: products)
  }
  
  func presentTotal(products: [CartProductsModel]) {
    let total = products.map { $0.price }.reduce(0, +)
    let totalFormat = "VALOR TOTAL: \(total.fortmatToCurrency)"
    viewController?.present(total: totalFormat)
  }
}
