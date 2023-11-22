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
  let sizes: [ListSizesItemViewModel]
}

struct ListSizesItemViewModel {
  let size: String
  let sku: String
  let isSelected: Bool
}

// MARK: Delegate

protocol ListSizesViewDelegate: AnyObject {
  func didTapSize(sku: String)
}

// MARK: ListSizes

class ListSizesView: UIView {
  // MARK: Public Properties
  
  var viewModel: ListSizesViewModel? {
    didSet {
      setup()
    }
  }

  weak var delegate: ListSizesViewDelegate?
  
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
    viewModel?.sizes.enumerated().forEach({ (index, item) in
      add(index: index, item: item)
    })
  }
  
  func add(index: Int, item: ListSizesItemViewModel) {
    let button = UIButton()
    
    button.setTitle(item.size, for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = getBackgroundColor(isSelected: item.isSelected)
    button.tag = index
    button.addTarget(self, action: #selector(didTapSize), for: .touchUpInside)
    
    container.addArrangedSubview(button)
  }
  
  @objc func didTapSize(button: UIButton) {
    guard let sku = viewModel?.sizes[button.tag].sku else { return }
    delegate?.didTapSize(sku: sku)
  }
  
  func getBackgroundColor(isSelected: Bool) -> UIColor {
    isSelected ? .black : .lightGray
  }
}

// MARK: Public Methods

extension ListSizesView {
  func clear() {
    container.removeSubviews()
  }
}
