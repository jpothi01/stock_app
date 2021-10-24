//
//  ListItem.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation
import UIKit

class TickerTableViewCell : UITableViewCell {
    struct Constants {
        static let margin = CGFloat(16)
        static let symbolWidth = CGFloat(64)
    }
    
    init(name: String, symbol: String) {
        super.init(style: .default, reuseIdentifier: symbol)
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let symbolLabel = UILabel()
        symbolLabel.text = symbol
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(nameLabel)
        self.addSubview(symbolLabel)
        
        self.addConstraint(
            NSLayoutConstraint(
                item: nameLabel,
                attribute: .left,
                relatedBy: .equal,
                toItem: self,
                attribute: .left,
                multiplier: 1,
                constant: Constants.margin
            )
        )
        
        self.addConstraint(
            NSLayoutConstraint(
                item: nameLabel,
                attribute: .right,
                relatedBy: .equal,
                toItem: symbolLabel,
                attribute: .left,
                multiplier: 1,
                constant: -Constants.margin
            )
        )
        
        self.addConstraint(
            NSLayoutConstraint(
                item: nameLabel,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: self,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.addConstraint(
            NSLayoutConstraint(
                item: symbolLabel,
                attribute: .right,
                relatedBy: .equal,
                toItem: self,
                attribute: .right,
                multiplier: 1,
                constant: -Constants.margin
            )
        )
        
        self.addConstraint(
            NSLayoutConstraint(
                item: symbolLabel,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: self,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.addConstraint(
            NSLayoutConstraint(
                item: symbolLabel,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: Constants.symbolWidth
            )
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
