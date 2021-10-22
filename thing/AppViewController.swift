//
//  AppViewController.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation
import UIKit

class AppViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, TickerUpdateDelegate {
    private let viewModel = TickerViewModel(stockPriceProvider: StockPriceProvider())
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        self.view.backgroundColor = Colors.backgroundColor
        self.title =
            NSLocalizedString(
                "Symbols",                  
                comment: "Name of the page displaying symbol names"
            )
        
        self.configureTableView()
        
        viewModel.delegate = self
        viewModel.refreshTicker()
    }
    
    // MARK: TickerUpdateDelegate
    func tickerDataWasUpdated() {
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(32)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 {
            return 0
        }
        
        return viewModel.tickerItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tickerItemIndex = indexPath.row
        guard tickerItemIndex < self.viewModel.tickerItems.count else {
            return TickerTableViewCell(name: "", symbol: "")
        }
        
        let tickerItem = self.viewModel.tickerItems[tickerItemIndex]
        return TickerTableViewCell(name: tickerItem.name, symbol: tickerItem.symbol)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            return
        }
        
        let tickerItemIndex = indexPath.row
        guard tickerItemIndex < self.viewModel.tickerItems.count else {
            return
        }
        
        let tickerItem = self.viewModel.tickerItems[tickerItemIndex]
        self.openDetailView(tickerItem: tickerItem)
    }
    
    // MARK: Private
    
    private func configureTableView() {
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: tableView,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .top,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: tableView,
                attribute: .right,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .right,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: tableView,
                attribute: .left,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .left,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: tableView,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .bottom,
                multiplier: 1,
                constant: 0
            )
        )
    }
    
    private func openDetailView(tickerItem: TickerItem) {
        self.viewModel.fetchSymbolPrices(forSymbol: tickerItem.symbol) { symbolPrices in
            let viewModel =
                SymbolDetailViewModel(tickerItem: tickerItem, symbolPrices: symbolPrices)
            let viewController = SymbolDetailViewController(viewModel: viewModel)
            self.navigationController!.pushViewController(viewController, animated: true)
        }
    }
}
