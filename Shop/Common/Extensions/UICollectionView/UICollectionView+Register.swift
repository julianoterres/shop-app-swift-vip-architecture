//
//  UICollectionView+Register.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import UIKit

extension UICollectionView {
  func registerHeader<T: ReusableView>(_: T.Type) {
    register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.defaultReuseIdentifier)
  }

  func register<T: ReusableView>(_: T.Type) {
    register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
  }

  func registerFooter<T: ReusableView>(_: T.Type) {
    register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.defaultReuseIdentifier)
  }
}
