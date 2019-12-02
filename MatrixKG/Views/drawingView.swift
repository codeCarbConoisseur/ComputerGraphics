//
//  drawingView.swift
//  MatrixKG
//
//  Created by Захар  Сегал on 25.11.2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation
import UIKit


class MyDrawingView: UIView {
    
    private var customPath: UIBezierPath?
    var customFigure: CustomFigure?
    private let segment: CGFloat = 15
    var model: Model2D? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addCoordinateAxes()
        guard let model = model else {
            fatalError("\n MODEL IS NIL \n")
        }
//        let view = CustomFigure()
//        addSubview(view)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        view.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        renderImage(model: model)
//        view.path = customPath
//        let scaleGesture = UIPinchGestureRecognizer(target: view, action: #selector(handleScale(sender:)))
//        view.addGestureRecognizer(scaleGesture)
    }
    
    @objc private func handleScale(sender: UIPinchGestureRecognizer) {
        customFigure?.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
    private func addCoordinateAxes() {
        let center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        let maxX = self.frame.width
        let maxY = self.frame.height
        let coordinatesPath = UIBezierPath()
        coordinatesPath.move(to: CGPoint(x: 0, y: center.y))
        coordinatesPath.addLine(to: CGPoint(x: maxX, y: center.y))
        coordinatesPath.move(to: CGPoint(x: center.x, y: 0))
        coordinatesPath.addLine(to: CGPoint(x: center.x, y: maxY))
        UIColor.red.set()
        coordinatesPath.stroke()
        let segmentPath = UIBezierPath()
        segmentPath.move(to: CGPoint(x: center.x + segment, y: center.y - 5))
        segmentPath.addLine(to: CGPoint(x: center.x + segment, y: center.y + 5))
        segmentPath.move(to: CGPoint(x: center.x - 5, y: center.y - segment))
        segmentPath.addLine(to: CGPoint(x: center.x + 5, y: center.y - segment))
        UIColor.black.set()
        segmentPath.stroke()
    }
    
    public func renderImage(model: Model2D) {
        let edges = model.getEdges()
        let path = UIBezierPath()
        for i in 0..<edges.getRows() {
            for j in 0..<1 {
                let pointToMoveTo: CGPoint = CGPoint().setCoordinateCGPoint(xInCoordinateSystem: CGFloat(model.getVertexX(xNumber: Int(edges[i,j]) - 1)) , yInCoordinateSystem: CGFloat( model.getVertexY(yNumber: Int(edges[i,j]) - 1)), superView: self, segment: segment)
                path.move(to: pointToMoveTo)
                let pointToAddLineTo: CGPoint = CGPoint().setCoordinateCGPoint(xInCoordinateSystem: CGFloat(model.getVertexX(xNumber: Int(edges[i,j+1]) - 1)), yInCoordinateSystem: CGFloat(model.getVertexY(yNumber: Int(edges[i,j+1]) - 1)), superView: self, segment: segment)
                path.addLine(to: pointToAddLineTo)
            }
        }
        path.close()
        UIColor.black.set()
        UIColor.green.setFill()
        path.stroke()
        path.fill()
    }
}

// MARK: расширение структуры CGPoint для перехода от экранных координат к координатам локальных координатных осей
extension CGPoint {
    public func setCoordinateCGPoint(xInCoordinateSystem: CGFloat, yInCoordinateSystem: CGFloat, superView: UIView, segment: CGFloat) -> CGPoint {
        let centerX = superView.frame.width / 2
        let centerY = superView.frame.height / 2
        let resultPoint = CGPoint(x: centerX + segment * xInCoordinateSystem, y: centerY - segment * yInCoordinateSystem)
        return resultPoint
    }
}
