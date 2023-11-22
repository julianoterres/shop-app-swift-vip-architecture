//
//  HomeInteractorTests.swift
//  ShopTests
//
//  Created by Juliano Terres on 22/11/23.
//

import XCTest
@testable import Shop

// MARK: HomeInteractorTests

final class HomeInteractorTests: XCTestCase {
  
  // MARK: Private Properties
  
  private var interactor: HomeInteractor!
  private var presenter: HomePresenterMock!
  private var service: HomeServiceMock!
  private var router: HomeRouterMock!
  private var cart: CartMock!
  
  // MARK: Setups
  
  override func setUp() {
    super.setUp()
    presenter = HomePresenterMock()
    service = HomeServiceMock()
    router = HomeRouterMock()
    cart = CartMock()
    
    interactor = HomeInteractor(
      presenter: presenter,
      service: service,
      router: router,
      cart: cart
    )
  }
  
  // MARK: Tests
  
  func testFetchProductsSuccess() {
    mockFetchSuccess()
    interactor.fetchProducts()
    
    XCTAssertEqual(presenter.didFetchSuccessCall, 1)
  }
  
  func testFetchProductsFailure() {
    mockfetchFailure()
    interactor.fetchProducts()
    
    XCTAssertEqual(presenter.didFetchFailureCall, 1)
  }
  
  func testDidTapCart() {
    interactor.didTapCart()
    
    XCTAssertEqual(router.navigationCall, 1)
    XCTAssertEqual(router.navigationScreen, .cart)
  }
  
  func testDidTapSize() {
    interactor.didTapSize(sku: "sku")
    
    XCTAssertEqual(presenter.didSizeSelectedCall, 1)
  }
  
  func testDidTapAddCartSuccess() {
    mockFetchSuccess()
    
    interactor.fetchProducts()
    interactor.didTapSize(sku: "sku")
    interactor.didTapAddCart(indexPath: IndexPath(row: 0, section: 0))
    
    XCTAssertEqual(cart.addCall, 1)
    XCTAssertEqual(presenter.didProductAddCartSucccessCall, 1)
    XCTAssertEqual(presenter.didSizeSelectedCall, 2)
  }
  
  func testDidTapAddCartFailure() {
    interactor.didTapAddCart(indexPath: nil)
    
    XCTAssertEqual(presenter.didProductAddCartFailureCall, 1)
  }
}

// MARK: Private Methods

private extension HomeInteractorTests {
  func mockFetchSuccess() {
    let products = [ProductApiModelMock.create()]
    let response = ProductsListApiResponse(products: products)
    
    service.fetchProductsListResult = .success(response)
  }
  
  func mockfetchFailure() {
    let error = NetworkError(type: .notFound)
    
    service.fetchProductsListResult = .failure(error)
  }
}
