//
//  CartProductListCell.swift
//  Shop
//
//  Created by Juliano Terres on 21/11/23.
//

import Kingfisher
import SnapKit
import UIKit

// MARK: View Model

struct CartProductListCellViewModel {
  let image: URL?
  let name: String
  let price: String
  let size: String
  let qty: String
}

// MARK: CartProductListCellDelegate

protocol CartProductListCellDelegate: AnyObject {
  func didTapRemove(indexPath: IndexPath?)
}

// MARK: HomeView

class CartProductListCell: UICollectionViewCell {
  // MARK: Public Properties

  var viewModel: CartProductListCellViewModel? {
    didSet {
      setup()
    }
  }
  
  weak var delegate: CartProductListCellDelegate?

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
  
  lazy var priceLabel: UILabel = {
    let element = UILabel()
    element.textColor = .black
    return element
  }()
  
  lazy var sizeLabel: UILabel = {
    let element = UILabel()
    element.text = "Tamanhos"
    element.textColor = .black
    return element
  }()
  
  lazy var qtyLabel: UILabel = {
    let element = UILabel()
    element.textColor = .black
    return element
  }()
  
  lazy var buttonRemove: UIButton = {
    let element = UIButton()
    element.backgroundColor = .black
    element.setTitle("Remover", for: .normal)
    element.setTitleColor(.white, for: .normal)
    element.addTarget(self, action: #selector(didTapRemove), for: .touchUpInside)
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

extension CartProductListCell: CodeView {
  func buildViewHierarchy() {
    contentView.addSubview(imageView)
    contentView.addSubview(infosView)
    contentView.addSubview(border)
    
    infosView.addArrangedSubview(nameLabel)
    infosView.addArrangedSubview(priceLabel)
    infosView.addArrangedSubview(sizeLabel)
    infosView.addArrangedSubview(qtyLabel)
    infosView.addArrangedSubview(buttonRemove)
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

private extension CartProductListCell {
  func setup() {
    setupImage()
    setupName()
    setupPrice()
    setupSize()
    setupQty()
  }
  
  func setupImage() {
    imageView.kf.setImage(with: viewModel?.image)
  }
  
  func setupName() {
    nameLabel.text = viewModel?.name
  }
  
  func setupPrice() {
    priceLabel.text = viewModel?.price
  }
  
  func setupSize() {
    sizeLabel.text = viewModel?.size
  }
  
  func setupQty() {
    qtyLabel.text = viewModel?.qty
  }
  
  func clear() {
    imageView.kf.cancelDownloadTask()
    imageView.image = nil
    nameLabel.text = .empty
    priceLabel.text = .empty
    sizeLabel.text = .empty
    qtyLabel.text = .empty
  }
  
  @objc func didTapRemove() {
    delegate?.didTapRemove(indexPath: indexPath)
  }
}

