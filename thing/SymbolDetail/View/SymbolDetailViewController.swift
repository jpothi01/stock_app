//
//  SymbolDetailViewController.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation
import UIKit

class SymbolDetailViewController : UIViewController, SymbolDetailPresenterToView {
    struct Constants {
        static let topMargin = CGFloat(108)
        static let margin = CGFloat(16)
        static let graphHeight = CGFloat(256)
        static let buttonWidth = CGFloat(128)
        static let buttonHeight = CGFloat(64)
    }
    
    private let presenter: SymbolDetailViewToPresenter
    private let nameLabel = UILabel()
    private let priceGraph = SymbolPriceGraph()
    private let button = UIButton()
    
    init(presenter: SymbolDetailViewToPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.backgroundColor
        self.configureLabels()
        self.configurePriceGraph()
        self.configureButton()
        
        self.presenter.viewDidLoad()
    }
    
    // MARK: SymbolDetailPresenterToView
    
    func showPrices(for symbol: SymbolDetailViewModel) {
        self.title = symbol.symbol
        nameLabel.text = symbol.name
        self.priceGraph.prices = symbol.priceByDay
    }
    
    // MARK: Private
    
    private func configureLabels() {
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.topMargin),
            nameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: Constants.margin),
            nameLabel.rightAnchor.constraint(lessThanOrEqualTo: self.view.rightAnchor, constant: -Constants.margin)
        ])
    }
    
    private func configurePriceGraph() {
        priceGraph.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(priceGraph)
        
        NSLayoutConstraint.activate([
            priceGraph.leftAnchor.constraint(
                equalTo: self.view.leftAnchor,
                constant: Constants.margin
            ),
            priceGraph.rightAnchor.constraint(
                equalTo: self.view.rightAnchor,
                constant: -Constants.margin
            ),
            priceGraph.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: Constants.margin
            ),
            priceGraph.heightAnchor.constraint(equalToConstant: Constants.graphHeight)
        ])
    }
    
    private func configureButton() {
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.backgroundColor = UIColor.blue
        
        self.button.setTitle("John", for: .normal)
        
        self.view.addSubview(self.button)
        
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(
                equalTo: self.priceGraph.bottomAnchor,
                constant: Constants.margin
            ),
            self.button.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            self.button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        self.button.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(onButtonTapped)))
    }
    
    @objc private func onButtonTapped() {
        self.presenter.reactToButtonTap()
    }
}
