//
//  ProductApiModel.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

struct ProductApiModel: Codable {
  let actualPrice: Double
  let color: String
  let discountPercentage: String
  let image: String
  let installments: String
  let name: String
  let onSale: Bool
  let regularPrice: Double
  let sizes: [ProductSizeApiModel]
  let style: String
  
  enum CodingKeys: String, CodingKey {
    case actualPrice = "actual_price"
    case discountPercentage = "discount_percentage"
    case onSale = "on_sale"
    case regularPrice = "regular_price"
    case color, image, installments, name, sizes, style
  }
}
