//
//  TickerPresenter.swift
//  thing
//
//  Created by John Pothier on 10/24/21.
//

import Foundation
import UIKit

class TickerPresenter : TickerInteractorToPresenter, TickerViewToPresenter {
    weak var view: TickerPresenterToView?
    
    private let interactor: TickerPresenterToInteractor
    private let router: TickerPresenterToRouter
    private var tickerItemSelected: TickerItem?
    
    init(interactor: TickerPresenterToInteractor, router: TickerPresenterToRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: TickerInteractorToPresenter
    func tickerItemsFetched(items: [TickerItem]) {
        view?.showTickerItems(items: items)
    }
    
    func symbolPricesFetched(prices: [SymbolPrice]) {
        guard let tickerItem = tickerItemSelected else {
            return
        }
        
        showTickerItemDetail(item: tickerItem, prices: prices)
    }
    
    // MARK: TickerViewToPresenter
    func showTickerItemDetail(item: TickerItem) {
        self.tickerItemSelected = item
        self.interactor.fetchSymbolPrices(symbol: item.symbol)
    }
    
    func viewDidLoad() {
        self.view?.showLoading()
        self.interactor.fetchTickerItems()
    }
    
    private func showTickerItemDetail(item: TickerItem, prices: [SymbolPrice]) {
        guard let viewController = view as? UIViewController else {
            print("View should be a view controller")
            return
        }
        
        self.router.showTickerItemDetail(from: viewController, tickerItem: item, symbolPrices: prices)
    }
}
