//
//  HomeViewController.swift
//  Shop
//
//  Created by Juliano Terres on 19/11/23.
//

import UIKit

// MARK: HomeViewController

final class HomeViewController: UIViewController {
  // MARK: Private Properties
  
  private let interactor: HomeInteractorProtocol
  
  // MARK: Inicialization

  init(interactor: HomeInteractorProtocol) {
    self.interactor = interactor
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
  }
}

// MARK: HomePresenterProtocol

protocol HomeViewControllerProtocol: AnyObject {
  
}

extension HomeViewController: HomeViewControllerProtocol {
  
}
