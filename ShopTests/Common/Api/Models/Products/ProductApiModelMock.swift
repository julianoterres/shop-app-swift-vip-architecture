//
//  ProductApiModelMock.swift
//  ShopTests
//
//  Created by Juliano Terres on 22/11/23.
//

@testable import Shop

final class ProductApiModelMock {
  static func create() -> ProductApiModel {
    ProductApiModel(
      actualPrice: 10,
      color: "color",
      discountPercentage: "discountPercentage",
      image: "image",
      installments: "installments",
      name: "name",
      onSale: true,
      regularPrice: 20,
      sizes: [
        ProductSizeApiModelMock.create()
      ],
      style: "style"
    )
  }
}
