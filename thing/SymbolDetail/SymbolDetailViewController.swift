//
//  SymbolDetailViewController.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation
import UIKit

class SymbolDetailViewController : UIViewController {
    struct Constants {
        static let topMargin = CGFloat(108)
        static let margin = CGFloat(16)
        static let graphHeight = CGFloat(256)
    }
    
    private let viewModel: SymbolDetailViewModel
    private let nameLabel = UILabel()
    
    init(viewModel: SymbolDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.backgroundColor
        self.title = self.viewModel.symbol
        
        self.configureLabels()
        self.configurePriceGraph()
    }
    
    private func configureLabels() {
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        nameLabel.text = viewModel.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(nameLabel)

        self.view.addConstraint(
            NSLayoutConstraint(
                item: nameLabel,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .top,
                multiplier: 1,
                constant: Constants.topMargin
            )
        )
        self.view.addConstraint(
            NSLayoutConstraint(
                item: nameLabel,
                attribute: .left,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .left,
                multiplier: 1,
                constant: Constants.margin
            )
        )
        self.view.addConstraint(
            NSLayoutConstraint(
                item: nameLabel,
                attribute: .right,
                relatedBy: .lessThanOrEqual,
                toItem: self.view,
                attribute: .right,
                multiplier: 1,
                constant: -Constants.margin
            )
        )
    }
    
    private func configurePriceGraph() {
        let priceGraph = SymbolPriceGraph(viewModel: self.viewModel)
        priceGraph.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(priceGraph)
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: priceGraph,
                attribute: .left,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .left,
                multiplier: 1,
                constant: Constants.margin
            )
        )
        self.view.addConstraint(
            NSLayoutConstraint(
                item: priceGraph,
                attribute: .right,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .right,
                multiplier: 1,
                constant: -Constants.margin
            )
        )
        self.view.addConstraint(
            NSLayoutConstraint(
                item: priceGraph,
                attribute: .top,
                relatedBy: .equal,
                toItem: nameLabel,
                attribute: .bottom,
                multiplier: 1,
                constant: Constants.margin
            )
        )
        self.view.addConstraint(
            NSLayoutConstraint(
                item: priceGraph,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: Constants.graphHeight
            )
        )
    }
}
