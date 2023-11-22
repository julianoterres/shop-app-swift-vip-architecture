//
//  UICollectionViewCell+IndexPath.swift
//  Shop
//
//  Created by Juliano Terres on 21/11/23.
//

import UIKit

extension UICollectionViewCell {
  var indexPath: IndexPath? {
    guard let superView = superview as? UICollectionView else { return nil }
    return superView.indexPath(for: self)
  }
}
