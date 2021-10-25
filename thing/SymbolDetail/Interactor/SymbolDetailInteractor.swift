//
//  SymbolDetailInteractor.swift
//  thing
//
//  Created by John Pothier on 10/24/21.
//

import Foundation

class SymbolDetailInteractor : SymbolDetailPresenterToInteractor {
    let prices: SymbolDetailViewModel
    
    init(prices: SymbolDetailViewModel) {
        self.prices = prices
    }
}
