//
//  AppViewController.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation
import UIKit

class TickerViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, TickerPresenterToView {
    private let presenter: TickerViewToPresenter
    private var isLoading = false
    private var progressView: UIView?
    private let tableView = UITableView()
    
    private var tickerItems: [TickerItem] = []
    
    init(presenter: TickerViewToPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = Colors.backgroundColor
        self.title =
            NSLocalizedString(
                "Symbols",                  
                comment: "Name of the page displaying symbol names"
            )
        
        self.configureTableView()
        self.presenter.viewDidLoad()
    }
    
    // MARK: TickerPresenterToView
    func showLoading() {
        self.isLoading = true
        self.updateTableView()
    }
    
    func showTickerItems(items: [TickerItem]) {
        self.tickerItems = items
        self.isLoading = false
        self.updateTableView()
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(32)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 || self.isLoading {
            return 0
        }
        
        return self.tickerItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tickerItemIndex = indexPath.row
        guard tickerItemIndex < self.tickerItems.count else {
            return TickerTableViewCell(name: "", symbol: "")
        }
        
        let tickerItem = self.tickerItems[tickerItemIndex]
        return TickerTableViewCell(name: tickerItem.name, symbol: tickerItem.symbol)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            return
        }
        
        let tickerItemIndex = indexPath.row
        guard tickerItemIndex < self.tickerItems.count else {
            return
        }
        
        let tickerItem = self.tickerItems[tickerItemIndex]
        self.openDetailView(tickerItem: tickerItem)
    }
    
    // MARK: Private
    private static func createProgressView() -> UIView {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func configureTableView() {
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        
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
    
    private func showProgressView() {
        let view = Self.createProgressView()
        self.view.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
        self.progressView = view
    }
    
    private func hideProgressView() {
        progressView?.removeFromSuperview()
        progressView = nil
    }
    
    private func updateTableView() {
        if (self.isLoading) {
            showProgressView()
        } else {
            hideProgressView()
        }
        
        self.tableView.reloadData()
    }
    
    private func openDetailView(tickerItem: TickerItem) {
        self.presenter.showTickerItemDetail(item: tickerItem)
    }
}
