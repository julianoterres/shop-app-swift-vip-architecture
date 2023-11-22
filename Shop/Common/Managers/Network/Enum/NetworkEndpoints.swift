//
//  NetworkEndpoints.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

enum NetworkEndpoints: String, Codable {
  // MARK: Public Properties

  var url: String {
    let baseURL = "https://run.mocky.io/v3"
    return "\(baseURL)\(rawValue)"
  }

  // MARK: Products

  case productsList = "/f7de77d2-286f-4a36-844d-a113ed7e4c24"
}
