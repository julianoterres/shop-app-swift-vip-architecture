//
//  UIView+CodeView.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

protocol CodeView {
  func buildViewHierarchy()
  func setupConstraints()
  func setupAditionalConfiguration()
  func setupView()
}

extension CodeView {
  func buildViewHierarchy() {}
  func setupConstraints() {}
  func setupAditionalConfiguration() {}
}

extension CodeView {
  func setupView() {
    buildViewHierarchy()
    setupConstraints()
    setupAditionalConfiguration()
  }
}
