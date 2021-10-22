//
//  ContentView.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//
import Foundation
import UIKit

class ContentView : UIView {
    init(color: UIColor) {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
