//
//  HomePresenterMock.swift
//  ShopTests
//
//  Created by Juliano Terres on 22/11/23.
//

@testable import Shop

final class HomePresenterMock: HomePresenterProtocol {
  var didFetchSuccessCall = 0
  func didFetchSuccess(products: [ProductApiModel]) {
    didFetchSuccessCall += 1
  }
  
  var didFetchFailureCall = 0
  func didFetchFailure() {
    didFetchFailureCall += 1
  }
  
  var didSizeSelectedCall = 0
  func didSizeSelected(products: [ProductApiModel], sizeSelecteds: [HomeProductSizeSelected]) {
    didSizeSelectedCall += 1
  }
  
  var didProductAddCartSucccessCall = 0
  func didProductAddCartSucccess() {
    didProductAddCartSucccessCall += 1
  }
  
  var didProductAddCartFailureCall = 0
  func didProductAddCartFailure() {
    didProductAddCartFailureCall += 1
  }
}
