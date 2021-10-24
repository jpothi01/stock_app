//
//  SymbolPrice.swift
//  thing
//
//  Created by John Pothier on 10/24/21.
//

import Foundation

struct SymbolPrice : Decodable {
    let date: Date
    let close: Decimal
    let symbol: String
}
