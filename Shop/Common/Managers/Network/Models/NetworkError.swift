//
//  NetworkError.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

struct NetworkError: Codable, Error {
  let type: NetworkHttpStatusType
}
