//
//  UICollectionView+DequeueReusable.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import UIKit

extension UICollectionView {
  func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
    }
    return cell
  }

  func dequeueReusableSupplementaryHeaderView<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T {
    guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                      withReuseIdentifier: T.defaultReuseIdentifier,
                                                      for: indexPath) as? T
    else {
      fatalError("Could not dequeue reusable supplementary with identifier: \(T.defaultReuseIdentifier)")
    }
    return view
  }

  func dequeueReusableSupplementaryFooterView<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T {
    guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                      withReuseIdentifier: T.defaultReuseIdentifier,
                                                      for: indexPath) as? T
    else {
      fatalError("Could not dequeue reusable supplementary with identifier: \(T.defaultReuseIdentifier)")
    }
    return view
  }
}
