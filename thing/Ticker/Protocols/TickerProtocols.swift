//
//  TickerProtocols.swift
//  thing
//
//  Created by John Pothier on 10/24/21.
//

import Foundation
import UIKit

protocol TickerPresenterToView : AnyObject {
    func showLoading()
    func showTickerItems(items: [TickerItem])
}

protocol TickerViewToPresenter : AnyObject {
    func viewDidLoad()
    func showTickerItemDetail(item: TickerItem)
}

protocol TickerPresenterToRouter : AnyObject {
    func showTickerItemDetail(from view: UIViewController, tickerItem: TickerItem, symbolPrices: [SymbolPrice])
}

protocol TickerInteractorToPresenter : AnyObject {
    func tickerItemsFetched(items: [TickerItem])
    func symbolPricesFetched(prices: [SymbolPrice])
}

protocol TickerPresenterToInteractor : AnyObject {
    func fetchTickerItems()
    func fetchSymbolPrices(symbol: String)
}
