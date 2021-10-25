//
//  SymbolDetailPresenter.swift
//  thing
//
//  Created by John Pothier on 10/24/21.
//

import Foundation
import UIKit

class SymbolDetailPresenter : SymbolDetailViewToPresenter {
    weak var view: SymbolDetailPresenterToView?
    
    private let interactor: SymbolDetailPresenterToInteractor
    private let router: SymbolDetailPresenterToRouter
    
    init(interactor: SymbolDetailPresenterToInteractor, router: SymbolDetailPresenterToRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: SymbolDetailPresenterToView
    func reactToButtonTap() {
        guard let viewController = view as? UIViewController else {
            return
        }
        
        self.router.showModal(from: viewController)
    }
    
    func viewDidLoad() {
        self.view?.showPrices(for: self.interactor.prices)
    }
}
