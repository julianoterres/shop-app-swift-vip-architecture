//
//  HomeService.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import Foundation

// MARK: HomeService

final class HomeService {
  // MARK: Private Properties
  
  private let productsService: ProductsServiceProtocol
  
  // MARK: Initialization

  init(productsService: ProductsServiceProtocol) {
    self.productsService = productsService
  }
}

// MARK: HomeServiceProtocol

protocol HomeServiceProtocol {
  func fetchProductsList(completion: @escaping (Result<ProductsListApiResponse?, NetworkError>) -> Void)
}

extension HomeService: HomeServiceProtocol {
  func fetchProductsList(completion: @escaping (Result<ProductsListApiResponse?, NetworkError>) -> Void) {
    productsService.fetchList(completion: completion)
  }
}
