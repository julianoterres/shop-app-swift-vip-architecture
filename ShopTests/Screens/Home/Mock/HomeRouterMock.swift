//
//  HomeRouterMock.swift
//  ShopTests
//
//  Created by Juliano Terres on 22/11/23.
//

@testable import Shop

final class HomeRouterMock: HomeRouterProtocol {
  var navigationCall = 0
  var navigationScreen: HomeRouter.Screens?
  func navigation(screen: HomeRouter.Screens) {
    navigationCall += 1
    navigationScreen = screen
  }
}
