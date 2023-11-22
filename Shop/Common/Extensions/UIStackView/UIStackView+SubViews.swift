//
//  UIStackView+SubViews.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import UIKit

extension UIStackView {
  func removeSubviews() {
    subviews.forEach { view in
      view.removeFromSuperview()
    }
  }

  func addSubviews(views: [UIView]) {
    views.forEach { view in
      addArrangedSubview(view)
    }
  }
}
