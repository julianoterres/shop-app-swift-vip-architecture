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
  
  // MARK: Private Properties
  
  private var products: [ProductListCellViewModel] = []
}

// MARK: HomePresenterProtocol

protocol HomePresenterProtocol {
  func didFetchSuccess(products: [ProductApiModel])
  func didFetchError()
  func didSizeSelected(products: [ProductApiModel], sizeSelecteds: [HomeProductSizeSelected])
}

extension HomePresenter: HomePresenterProtocol {
  func didFetchSuccess(products: [ProductApiModel]) {
    presentProducts(products: products)
  }
  
  func didFetchError() {
    viewController?.present(error: "Falha ao encontrar os produtos")
  }
  
  func didSizeSelected(products: [ProductApiModel], sizeSelecteds: [HomeProductSizeSelected]) {
    presentProducts(products: products, sizeSelecteds: sizeSelecteds)
  }
}

// MARK: Private Methods

private extension HomePresenter {
  func presentProducts(
    products: [ProductApiModel],
    sizeSelecteds: [HomeProductSizeSelected] = []
  ) {
    self.products = parseProducts(products: products, sizeSelecteds: sizeSelecteds)
    viewController?.present(products: self.products)
  }
  
  func parseProducts(
    products: [ProductApiModel],
    sizeSelecteds: [HomeProductSizeSelected]
  ) -> [ProductListCellViewModel] {
    return products.map {
      parseProductApiToProductViewModel(
        product: $0,
        sizeSelecteds: sizeSelecteds
      )
    }
  }
  
  func parseProductApiToProductViewModel(
    product: ProductApiModel,
    sizeSelecteds: [HomeProductSizeSelected]
  ) -> ProductListCellViewModel {
    ProductListCellViewModel(
      image: URL(string: product.image),
      name: product.name,
      promotionText: product.onSale ? "Em promoção" : .empty,
      prices: parsePrices(product: product),
      sizes: parseSizes(product: product, sizeSelecteds: sizeSelecteds)
    )
  }
  
  func parsePrices(product: ProductApiModel) -> ListPricesViewModel {
    ListPricesViewModel(
      regularPrice: product.regularPrice,
      actualPrice: product.actualPrice,
      isPromotion: product.regularPrice != product.actualPrice
    )
  }
  
  func parseSizes(
    product: ProductApiModel,
    sizeSelecteds: [HomeProductSizeSelected]
  ) -> ListSizesViewModel {
    let sizes = product.sizes.filter { $0.available }.map { productSize in
      print(sizeSelecteds.filter { $0.style == product.style && $0.size == productSize.size }.count)
      return ListSizesItemViewModel(
        size: productSize.size,
        isSelected: sizeSelecteds.filter { $0.style == product.style && $0.size == productSize.size }.count > 0
      )
    }
    
    return ListSizesViewModel(sizes: sizes)
  }
}
