//
//  HomePresenter.swift
//  Shop
//
//  Created by Juliano Terres on 19/11/23.
//

import Foundation

// MARK: HomePresenter

final class HomePresenter {
  // MARK: Public Properties
  
  weak var viewController: HomeViewControllerProtocol?
}

// MARK: HomePresenterProtocol

protocol HomePresenterProtocol {
  func didFetchSuccess(products: [ProductApiModel])
  func didFetchError()
}

extension HomePresenter: HomePresenterProtocol {
  func didFetchSuccess(products: [ProductApiModel]) {
    let products = parseProducts(products: products)
    viewController?.present(products: products)
  }
  
  func didFetchError() {
    viewController?.present(error: "Falha ao encontrar os produtos")
  }
}

// MARK: Private Methods

private extension HomePresenter {
  func parseProducts(products: [ProductApiModel]) -> [ProductListCellViewModel] {
    return products.map {
      parseProductApiToProductViewModel(product: $0)
    }
  }
  
  func parseProductApiToProductViewModel(product: ProductApiModel) -> ProductListCellViewModel {
    ProductListCellViewModel(
      image: URL(string: product.image),
      name: product.name,
      promotionText: product.onSale ? "Em promoção" : .empty,
      prices: parsePrices(product: product),
      sizes: parseSizes(product: product)
    )
  }
  
  func parsePrices(product: ProductApiModel) -> ListPricesViewModel {
    ListPricesViewModel(
      regularPrice: product.regularPrice,
      actualPrice: product.actualPrice,
      isPromotion: product.regularPrice != product.actualPrice
    )
  }
  
  func parseSizes(product: ProductApiModel) -> ListSizesViewModel {
    let sizes = product.sizes.filter { $0.available }.map {
      $0.size
    }
    
    return ListSizesViewModel(sizes: sizes)
  }
}
