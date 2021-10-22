//
//  TickerViewModel.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation

protocol TickerUpdateDelegate : AnyObject {
    func tickerDataWasUpdated()
}

class TickerViewModel {
    weak var delegate: TickerUpdateDelegate?
    
    private(set) var tickerItems: [TickerItem] = []
    private let stockPriceProvider: StockPriceProviding
    
    init(stockPriceProvider: StockPriceProviding) {
        self.stockPriceProvider = stockPriceProvider
    }
    
    func refreshTicker() {
        stockPriceProvider.fetchTicker() { [weak self] response in
            self?.tickerItems = response.data
            self?.delegate?.tickerDataWasUpdated()
        }
    }
    
    func fetchSymbolPrices(forSymbol symbol: String, callback: @escaping ([SymbolPrice]) -> ()) {
        self.stockPriceProvider.fetchEOD(symbol: symbol) { response in
            callback(response.data)
        }
    }
}
