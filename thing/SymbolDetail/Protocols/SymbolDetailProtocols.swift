//
//  SymbolDetailProtocols.swift
//  thing
//
//  Created by John Pothier on 10/24/21.
//

import Foundation
import UIKit

protocol SymbolDetailPresenterToView : AnyObject {
    func showPrices(for symbol: SymbolDetailViewModel)
}

protocol SymbolDetailViewToPresenter : AnyObject {
    func viewDidLoad()
    func reactToButtonTap()
}

protocol SymbolDetailPresenterToRouter : AnyObject {
    func showModal(from view: UIViewController)
}

protocol SymbolDetailInteractorToPresenter : AnyObject {
    
}

protocol SymbolDetailPresenterToInteractor : AnyObject {
    var prices: SymbolDetailViewModel { get }
}
