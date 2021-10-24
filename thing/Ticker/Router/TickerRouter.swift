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
        let viewModel =
            SymbolDetailViewModel(tickerItem: tickerItem, symbolPrices: symbolPrices)
        let viewController = SymbolDetailViewController(viewModel: viewModel)
        view.navigationController!.pushViewController(viewController, animated: true)
    }
    
    
}
