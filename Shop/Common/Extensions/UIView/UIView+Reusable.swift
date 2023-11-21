//
//  UIView+Reusable.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import UIKit

protocol ReusableView: AnyObject {
  static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
  static var defaultReuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: ReusableView {}
extension UICollectionReusableView: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}
