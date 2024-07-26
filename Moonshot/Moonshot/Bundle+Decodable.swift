//
//  Bundle+Decodable.swift
//  Moonshot
//
//  Created by Roelf Sluman on 26/07/2024.
//

import Foundation

extension Bundle {
  func decode<T: Decodable>(_ file: String) -> T {
    guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
      fatalError("URL for \(file) not found in bundle")
    }
    
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Invalid data for file in bundle: \(file)")
    }
    
    let decoder = JSONDecoder()
    
    do {
      return try decoder.decode(T.self, from: data)
    } catch DecodingError.keyNotFound(let key, let context) {
      fatalError("Failed to decode file in bundle: \(file). Missing key: \(key.stringValue). \(context.debugDescription)")
    } catch DecodingError.typeMismatch(_, let context) {
      fatalError("Failed to decode file in bundle: \(file). Type Mismatch. \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let type, let context) {
      fatalError("Failed to decode file in bundle: \(file). not found: \(type) value. \(context.debugDescription)")
    } catch DecodingError.dataCorrupted(let context) {
      fatalError("Failed to decode file in bundle: \(file). Data is corrupt. \(context.debugDescription)")
    } catch {
      fatalError("Failed to decode file in bundle: \(file). \(error.localizedDescription)")
    }
  }
}
