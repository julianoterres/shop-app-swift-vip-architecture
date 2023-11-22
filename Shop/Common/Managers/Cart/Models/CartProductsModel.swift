//
//  CartProductsModel.swift
//  Shop
//
//  Created by Juliano Terres on 21/11/23.
//

struct CartProductsModel: Codable, Equatable {
  let sku: String
  let name: String
  let image: String
  let size: String
  let price: Double
}
