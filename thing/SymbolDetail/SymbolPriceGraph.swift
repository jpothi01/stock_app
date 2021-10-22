//
//  SymbolPriceGraph.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation
import UIKit

class SymbolPriceGraph : UIView {
    struct Constants {
        static let axisColor = UIColor.gray
        static let lineColor =
            UIColor(
                red: CGFloat(0x7b) / 255,
                green: CGFloat(0xe2) / 255,
                blue: CGFloat(0x1b) / 255,
                alpha: CGFloat(1)
            )
        static let maxWeeksOfPrices = 24
        static let maxDaysOfPrices = maxWeeksOfPrices * 5
    }
    
    private let axisLayer = CAShapeLayer()
    private let lineLayer = CAShapeLayer()
    private let prices: [Decimal]
    
    init(viewModel: SymbolDetailViewModel) {
        self.prices = Self.calculateMostRecentPrices(viewModel: viewModel)
        
        super.init(frame: CGRect.zero)
        self.layer.addSublayer(axisLayer)
        self.layer.addSublayer(lineLayer)
    }
    
    override func draw(_ rect: CGRect) {
        axisLayer.frame = self.bounds
        lineLayer.frame = self.bounds
        self.drawAxes()
        self.drawLines()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    private static func calculateMostRecentPrices(viewModel: SymbolDetailViewModel) -> [Decimal] {
        let numDaysOfPrices = min(viewModel.priceByDay.count, Constants.maxDaysOfPrices)
        let prices = viewModel.priceByDay
        return Array(prices[(prices.count - numDaysOfPrices)..<prices.count])
    }
    private func drawAxes() {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))

        axisLayer.path = path
        axisLayer.strokeColor = Constants.axisColor.cgColor
        axisLayer.fillColor = UIColor.clear.cgColor
    }
    
    private func drawLines() {
        guard let maxPrice = self.prices.max() else {
            return
        }
        
        let pointsY = self.prices.map { price -> CGFloat in
            let ratio = (maxPrice - price) / maxPrice
            let doubleRatio = NSDecimalNumber(decimal: ratio).doubleValue
            return self.bounds.height * CGFloat(doubleRatio)
        }
        
        let path = CGMutablePath()
        let xStep = self.bounds.width / CGFloat(pointsY.count)
        var x = CGFloat(0)
        
        path.move(to: CGPoint(x: x, y: pointsY[0]))
        
        for point in pointsY {
            x += xStep
            path.addLine(to: CGPoint(x: x, y: point))
        }

        lineLayer.path = path
        lineLayer.strokeColor = Constants.lineColor.cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
    }
}
