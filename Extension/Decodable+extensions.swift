//
//  Decodable+extensions.swift
//  Todo
//
//  Created by Arthit Thongpan on 27/3/2564 BE.
//

import Foundation

extension Decodable {
  init(from: Any) throws {
    let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    self = try decoder.decode(Self.self, from: data)
  }
}
