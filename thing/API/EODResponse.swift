//
//  SymbolPriceHistory.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation

struct EODResponse : Decodable {
    let data: [SymbolPrice]
}
