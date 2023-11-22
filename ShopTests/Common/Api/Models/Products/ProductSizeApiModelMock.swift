//
//  ProductSizeApiModelMock.swift
//  ShopTests
//
//  Created by Juliano Terres on 22/11/23.
//

@testable import Shop

final class ProductSizeApiModelMock {
  static func create() -> ProductSizeApiModel {
    ProductSizeApiModel(
      available: true,
      size: "size",
      sku: "sku"
    )
  }
}
