//
//  SymbolDetailViewModel.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation

class SymbolDetailViewModel {
    let symbol: String
    let name: String
    let priceByDay: [Decimal]
    
    init(tickerItem: TickerItem, symbolPrices: [SymbolPrice]) {
        self.priceByDay = symbolPrices.map { $0.close }
        self.symbol = tickerItem.symbol
        self.name = tickerItem.name
    }
}
