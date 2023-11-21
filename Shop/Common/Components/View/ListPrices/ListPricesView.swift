//
//  ListPricesView.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import SnapKit
import UIKit

// MARK: View Model

struct ListPricesViewModel {
  let regularPrice: String
  let actualPrice: String
  let isPromotion: Bool
}

// MARK: ListSizes

class ListPricesView: UIView {
  // MARK: Public Properties
  
  var viewModel: ListPricesViewModel? {
    didSet {
      setup()
    }
  }

  // MARK: Elements

  lazy var container: UIStackView = {
    let element = UIStackView()
    element.spacing = 8
    return element
  }()
  
  lazy var regularPriceLabel: UILabel = {
    let element = UILabel()
    element.textColor = .black
    return element
  }()
  
  lazy var actualPriceLabel: UILabel = {
    let element = UILabel()
    element.textColor = .black
    return element
  }()

  // MARK: Inicialization

  override init(frame _: CGRect = .zero) {
    super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    setupView()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: Code View

extension ListPricesView: CodeView {
  func buildViewHierarchy() {
    addSubview(container)
    container.addArrangedSubview(regularPriceLabel)
    container.addArrangedSubview(actualPriceLabel)
  }
  
  func setupConstraints() {
    container.snp.makeConstraints {
      $0.top.leading.bottom.equalToSuperview()
    }
  }
  
  func setupAditionalConfiguration() {
    backgroundColor = .white
  }
}

// MARK: Private Methods

private extension ListPricesView {
  func setup() {
    setupRegularPrice()
    setupActualPrice()
  }
  
  func setupRegularPrice() {
    guard viewModel?.isPromotion == true else {
      regularPriceLabel.text = viewModel?.regularPrice
      return
    }
    regularPriceLabel.attributedText = viewModel?.regularPrice.strikeThrough
  }
  
  func setupActualPrice() {
    actualPriceLabel.text = viewModel?.actualPrice
    actualPriceLabel.isHidden = viewModel?.isPromotion == false
  }
}

// MARK: Public Methods

extension ListPricesView {
  func clear() {
    regularPriceLabel.text = .empty
    regularPriceLabel.attributedText = NSAttributedString(string: "")
    actualPriceLabel.text = .empty
    actualPriceLabel.isHidden = false
  }
}
