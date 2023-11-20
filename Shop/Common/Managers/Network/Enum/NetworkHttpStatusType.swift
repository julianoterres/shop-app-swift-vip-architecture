//
//  NetworkHttpStatusType.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

enum NetworkHttpStatusType: Int, Codable {
  case success = 200
  case noData = 204
  case badRquest = 400
  case unauthorized = 401
  case forbidden = 403
  case notFound = 404
}
