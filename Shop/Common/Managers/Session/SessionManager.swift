//
//  SessionManager.swift
//  Shop
//
//  Created by Juliano Terres on 21/11/23.
//

import Foundation

// MARK: SessionManager

final class SessionManager {}

// MARK: SessionManagerProtocol

protocol SessionManagerProtocol {
  func save<T: Codable>(value: T, key: SessionManagerKey)
  func get<T: Codable>(dataType: T.Type, key: SessionManagerKey) -> T?
  func delete(key: SessionManagerKey)
  func clean()
}

extension SessionManager: SessionManagerProtocol {
  func save<T: Codable>(value: T, key: SessionManagerKey) {
    guard let data = try? JSONEncoder().encode(value) else { return }
    UserDefaults.standard.setValue(data, forKey: key.rawValue)
  }

  func get<T: Codable>(dataType _: T.Type, key: SessionManagerKey) -> T? {
    guard let data = UserDefaults.standard.data(forKey: key.rawValue) else { return nil }
    return try? JSONDecoder().decode(T.self, from: data)
  }

  func delete(key: SessionManagerKey) {
    UserDefaults.standard.removeObject(forKey: key.rawValue)
  }

  func clean() {
    SessionManagerKey.allCases.forEach { delete(key: $0) }
  }
}
