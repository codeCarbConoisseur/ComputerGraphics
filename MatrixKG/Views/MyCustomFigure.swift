//
//  MyCustomFigure.swift
//  MatrixKG
//
//  Created by Захар  Сегал on 29.11.2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation
import UIKit

class CustomFigure: UIView {
    
    var path: UIBezierPath? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let path = path else {
            fatalError("\n PATH PASSED TO CUSTOM VIEW IS NIL \n")
        }
        drawWithPath(path: path)
    }
    
    private func drawWithPath(path: UIBezierPath) {
        let newPath = path
        let fillColor: UIColor = .green
        fillColor.setFill()
        newPath.lineWidth = 1.5
        let strokeColor: UIColor = .orange
        strokeColor.setStroke()
        newPath.fill()
        newPath.stroke()
    }
}
