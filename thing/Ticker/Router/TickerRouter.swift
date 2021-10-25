//
//  TickerRouter.swift
//  thing
//
//  Created by John Pothier on 10/24/21.
//

import Foundation
import UIKit

class TickerRouter : TickerPresenterToRouter {
    func showTickerItemDetail(from view: UIViewController, tickerItem: TickerItem, symbolPrices: [SymbolPrice]) {
        let prices =
            SymbolDetailViewModel(tickerItem: tickerItem, symbolPrices: symbolPrices)
        let interactor = SymbolDetailInteractor(prices: prices)
        let router = SymbolDetailRouter()
        let presenter = SymbolDetailPresenter(interactor: interactor, router: router)
        
        let viewController = SymbolDetailViewController(presenter: presenter)
        
        presenter.view = viewController
        
        view.navigationController!.pushViewController(viewController, animated: true)
    }
}
