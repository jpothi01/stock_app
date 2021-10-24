//
//  TickerInteractor.swift
//  thing
//
//  Created by John Pothier on 10/24/21.
//

import Foundation

class TickerInteractor : TickerPresenterToInteractor {
    weak var presenter: TickerInteractorToPresenter?
    
    private let stockPriceProvider: StockPriceProviding
    
    init(stockPriceProvider: StockPriceProviding) {
        self.stockPriceProvider = stockPriceProvider
    }
    
    func fetchTickerItems() {
        self.stockPriceProvider.fetchTicker() { [weak self] response in
            self?.presenter?.tickerItemsFetched(items: response.data)
        }
    }
    
    func fetchSymbolPrices(symbol: String) {
        self.stockPriceProvider.fetchEOD(symbol: symbol) { [weak self] response in
            self?.presenter?.symbolPricesFetched(prices: response.data)
        }
    }
}
