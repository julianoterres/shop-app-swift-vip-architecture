//
//  HomeView.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import SnapKit
import UIKit

// MARK: HomeView

class HomeView: UIView {
  // MARK: Private Properties

  // MARK: Elements

  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 16
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(ProductListCell.self)
    
    return collectionView
  }()

  // MARK: Inicialization

  override init(frame _: CGRect = .zero) {
    super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    setupView()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: CodeView

extension HomeView: CodeView {
  func buildViewHierarchy() {
    addSubview(collectionView)
  }

  func setupConstraints() {
    collectionView.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide.snp.top)
      $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
      $0.leading.trailing.equalToSuperview()
    }
  }

  func setupAditionalConfiguration() {
    backgroundColor = .white
  }
}

// MARK: HomeViewProtocol

protocol HomeViewProtocol: UIView {
  func reloadProducts()
  func setupCollection(delegate: (UICollectionViewDataSource & UICollectionViewDelegate))
}

extension HomeView: HomeViewProtocol {
  func reloadProducts() {
    collectionView.reloadData()
  }
  
  func setupCollection(delegate: (UICollectionViewDataSource & UICollectionViewDelegate)) {
    collectionView.dataSource = delegate
    collectionView.delegate = delegate
  }
}
