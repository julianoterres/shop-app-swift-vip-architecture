//
//  HomeServiceMock.swift
//  ShopTests
//
//  Created by Juliano Terres on 22/11/23.
//

@testable import Shop

final class HomeServiceMock: HomeServiceProtocol {
  var fetchProductsListCall = 0
  var fetchProductsListResult:  Result<ProductsListApiResponse?, NetworkError>?
  
  func fetchProductsList(completion: @escaping (Result<ProductsListApiResponse?, NetworkError>) -> Void) {
    fetchProductsListCall += 1
    completion(fetchProductsListResult!)
  }
}
