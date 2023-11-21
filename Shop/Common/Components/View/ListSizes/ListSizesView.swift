//
//  ListSizesView.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import SnapKit
import UIKit

// MARK: View Model

struct ListSizesViewModel {
  let sizes: [String]
}

// MARK: ListSizes

class ListSizesView: UIView {
  // MARK: Public Properties
  
  var viewModel: ListSizesViewModel? {
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

extension ListSizesView: CodeView {
  func buildViewHierarchy() {
    addSubview(container)
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

private extension ListSizesView {
  func setup() {
    addSizes()
  }
  
  func addSizes() {
    viewModel?.sizes.forEach({
      add(size: $0)
    })
  }
  
  func add(size: String) {
    let button = UIButton()
    
    button.setTitle(size, for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .lightGray
    
    container.addArrangedSubview(button)
  }
}

// MARK: Public Methods

extension ListSizesView {
  func clear() {
    container.removeSubviews()
  }
}
