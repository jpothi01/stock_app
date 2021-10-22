//
//  SymbolPriceHistory.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation

struct SymbolPrice : Decodable {
    let date: Date
    let close: Decimal
    let symbol: String
}

struct EODResponse : Decodable {
    let data: [SymbolPrice]
}
