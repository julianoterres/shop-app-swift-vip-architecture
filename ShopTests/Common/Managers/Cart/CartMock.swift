//
//  CartMock.swift
//  ShopTests
//
//  Created by Juliano Terres on 22/11/23.
//

@testable import Shop

final class CartMock: CartManagerProtocol {
  var addCall = 0
  func add(product: CartProductsModel) {
    addCall += 1
  }
  
  var removeCall = 0
  func remove(product: CartProductsModel) {
    removeCall += 1
  }
  
  var getProductsCall = 0
  func getProducts() -> [CartProductsModel] {
    getProductsCall += 1
    return []
  }
}
