//
//  ProductsService.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import Foundation

// MARK: ProductsService

final class ProductsService {
    
  // MARK: Private Properties
  
  private let network: NetworkManagerProtocol
  
  // MARK: Initialization
  
  init(
    network: NetworkManagerProtocol
  ) {
    self.network = network
  }
  
}

// MARK: ProductsServiceProtocol

protocol ProductsServiceProtocol {
  func fetchList(completion: @escaping (Result<ProductsListApiResponse?, NetworkError>) -> Void)
}

extension ProductsService: ProductsServiceProtocol {
  func fetchList(completion: @escaping (Result<ProductsListApiResponse?, NetworkError>) -> Void) {
    let requestConfigs = NetworkRequestConfig(
      method: .get,
      endPoint: .productsList,
      responseType: ProductsListApiResponse.self
    )

    network.request(configs: requestConfigs) { result in
      switch result {
        case let .success(response):
          completion(.success(response.data))
        case let .failure(error):
          completion(.failure(error))
      }
    }
  }
}
