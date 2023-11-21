//
//  CartViewController.swift
//  Shop
//
//  Created by Juliano Terres on 21/11/23.
//

import UIKit

// MARK: CartViewController

final class CartViewController: UIViewController {
  // MARK: Private Properties
  
  private let interactor: CartInteractorProtocol
  private let screenView: CartViewProtocol
  
  // MARK: Inicialization

  init(
    screenView: CartViewProtocol,
    interactor: CartInteractorProtocol
  ) {
    self.screenView = screenView
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
    setup()
  }
  
  override func loadView() {
    view = screenView
  }
}

// MARK: CartPresenterProtocol

protocol CartViewControllerProtocol: AnyObject {
}

extension CartViewController: CartViewControllerProtocol {
}

// MARK: Private Methods

private extension CartViewController {
  func setup() {
    setupTitle()
  }
  
  func setupTitle() {
    title = "Carrinho"
  }
}
