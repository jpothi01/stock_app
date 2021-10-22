//
//  StockPriceProviding.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation

protocol StockPriceProviding {
    func fetchTicker(callback: @escaping (TickerResponse) -> ())
    func fetchEOD(symbol: String, callback: @escaping (EODResponse) -> ())
}
