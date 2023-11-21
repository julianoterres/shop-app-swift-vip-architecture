//
//  ProductListCell.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import Kingfisher
import SnapKit
import UIKit

// MARK: View Model

struct ProductListCellViewModel {
  let image: URL?
  let name: String
  let promotionText: String
  let prices: ListPricesViewModel
  let sizes: ListSizesViewModel
}

// MARK: HomeView

class ProductListCell: UICollectionViewCell {
  // MARK: Public Properties

  var viewModel: ProductListCellViewModel? {
    didSet {
      setup()
    }
  }
  
  // MARK: Elements

  lazy var imageView: UIImageView = {
    let element = UIImageView()
    element.contentMode = .scaleAspectFit
    return element
  }()
  
  lazy var infosView: UIStackView = {
    let element = UIStackView()
    element.axis = .vertical
    element.spacing = 8
    return element
  }()
  
  lazy var nameLabel: UILabel = {
    let element = UILabel()
    element.textColor = .black
    return element
  }()
  
  lazy var promotionLabel: UILabel = {
    let element = UILabel()
    element.textColor = .black
    return element
  }()
  
  lazy var pricesView: ListPricesView = {
    let element = ListPricesView()
    return element
  }()
  
  lazy var sizesLabel: UILabel = {
    let element = UILabel()
    element.text = "Tamanhos"
    element.textColor = .black
    return element
  }()
  
  lazy var sizesView: ListSizesView = {
    let element = ListSizesView()
    return element
  }()
  
  lazy var buttonCart: UIButton = {
    let element = UIButton()
    element.backgroundColor = .black
    element.setTitle("Adicionar no carriho", for: .normal)
    element.setTitleColor(.white, for: .normal)
    return element
  }()
  
  lazy var border: UIView = {
    let element = UIView()
    element.backgroundColor = .black
    return element
  }()

  // MARK: Inicialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
    attributes.size.width = superview?.bounds.width ?? 0
    return attributes
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    clear()
  }
}

// MARK: CodeView

extension ProductListCell: CodeView {
  func buildViewHierarchy() {
    contentView.addSubview(imageView)
    contentView.addSubview(infosView)
    contentView.addSubview(border)
    
    infosView.addArrangedSubview(nameLabel)
    infosView.addArrangedSubview(promotionLabel)
    infosView.addArrangedSubview(pricesView)
    infosView.addArrangedSubview(sizesLabel)
    infosView.addArrangedSubview(sizesView)
    infosView.addArrangedSubview(buttonCart)
  }

  func setupConstraints() {
    imageView.snp.makeConstraints {
      $0.top.leading.equalToSuperview()
      $0.bottom.equalTo(border.snp.top).offset(-16)
      $0.width.equalTo(100)
      $0.height.equalTo(200)
    }
    infosView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-16)
      $0.leading.equalTo(imageView.snp.trailing).offset(16)
    }
    border.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.trailing.leading.equalToSuperview()
      $0.height.equalTo(1)
    }
  }

  func setupAditionalConfiguration() {
    backgroundColor = .white
  }
}

// MARK: Private Methods

private extension ProductListCell {
  func setup() {
    setupImage()
    setupName()
    setupPromotion()
    setupPrices()
    setupSizes()
  }
  
  func setupImage() {
    imageView.kf.setImage(with: viewModel?.image)
  }
  
  func setupName() {
    nameLabel.text = viewModel?.name
  }
  
  func setupPromotion() {
    promotionLabel.text = viewModel?.promotionText
    promotionLabel.isHidden = viewModel?.promotionText.isEmpty ?? false
  }
  
  func setupPrices() {
    pricesView.viewModel = viewModel?.prices
  }
  
  func setupSizes() {
    sizesView.viewModel = viewModel?.sizes
  }
  
  func clear() {
    imageView.kf.cancelDownloadTask()
    imageView.image = nil
    nameLabel.text = .empty
    promotionLabel.text = .empty
    promotionLabel.isHidden = false
    pricesView.clear()
    sizesView.clear()
  }
}
