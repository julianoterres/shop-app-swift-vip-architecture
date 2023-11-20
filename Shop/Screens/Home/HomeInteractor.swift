//
//  HomeInteractor.swift
//  Shop
//
//  Created by Juliano Terres on 19/11/23.
//

import Foundation

// MARK: HomeInteractor

final class HomeInteractor {
  
  private let presenter: HomePresenterProtocol
  
  init(presenter: HomePresenterProtocol) {
    self.presenter = presenter
  }
  
}


// MARK: HomeInteractorProtocol

protocol HomeInteractorProtocol {
  
}

extension HomeInteractor: HomeInteractorProtocol {
}
