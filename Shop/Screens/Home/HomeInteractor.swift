//
//  HomeInteractor.swift
//  Shop
//
//  Created by Juliano Terres on 19/11/23.
//

import Foundation

// MARK: HomeInteractor

final class HomeInteractor {
  // MARK: Private Properties
  
  private let presenter: HomePresenterProtocol
  private let service: HomeServiceProtocol
  private var products: [ProductApiModel] = []
  
  // MARK: Initialization
  
  init(
    presenter: HomePresenterProtocol,
    service: HomeServiceProtocol
  ) {
    self.presenter = presenter
    self.service = service
  }
}

// MARK: HomeInteractorProtocol

protocol HomeInteractorProtocol {
  func fetchProducts()
}

extension HomeInteractor: HomeInteractorProtocol {
  func fetchProducts() {
    service.fetchProductsList { [weak self] response in
      switch response {
      case let .success(response):
        self?.didFetchProductsListSuccess(response: response)
      case .failure:
        self?.didFetchProductsListFailure()
      }
    }
  }
}

// MARK: Private Methods

private extension HomeInteractor {
  func didFetchProductsListSuccess(response: ProductsListApiResponse?) {
    guard let products = response?.products else { return }
    self.products = products
    presenter.didFetchSuccess(products: products)
  }
  
  func didFetchProductsListFailure() {
    presenter.didFetchError()
  }
}
