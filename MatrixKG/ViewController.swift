//
//  ViewController.swift
//  MatrixKG
//
//  Created by Захар  Сегал on 17.11.2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let firstArray:[Double] = [5,5,5,5,5,5]
    let edges: [Double] = [1,2]
//    let secondArray:[Double] = [15,10,5,0,15,10]
//    let thirdArray:[Double] = [10,20,10,20,10,20]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print("hello world!")
        
        let label = UILabel()
        label.textColor = .darkText
        label.text = "Hello world!"
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        
        let firstMatrix = Matrix(numberOfRows: 3, numberOfCols: 2, list: firstArray)
        let edgesMatrix = Matrix(numberOfRows: 1, numberOfCols: 2, list: edges)
        
        
//        let thirdMatrix = Matrix(numberOfRows: 3, numberOfCols: 2, list: thirdArray)
//        print("")
        print("First Matrix is: \n\(firstMatrix.description)")
        print("")
        print("Edges Matrix is: \n\(edgesMatrix.description)")
        print("")
//        print("Third Matrix is: \n\(thirdMatrix.description)")
//        print("")
//        let resultMatrix = firstMatrix + thirdMatrix
//        print("Sum of first and third matrix is \n\(resultMatrix)")
//        print("")
//        let secondResultMatrix = firstMatrix * secondMatrix
//        print("Multiplication of first and second matrix is \n\(secondResultMatrix)")
//        print("")
        
        let model = Model2D(vertices: firstMatrix, edges: edgesMatrix)
        print("")
        print("Vertices: \(model.getVertices())")
        print("Edges: \(model.getEdges())")
        print("")
        let emptyMatrix = Matrix(numberOfRows: 0, numberOfCols: 0, list: [Double]())
        model.apply(transformation: emptyMatrix.translation(x: 2,y: -1))
        model.apply(transformation: emptyMatrix.mappingX())
        model.apply(transformation: emptyMatrix.scaling(kx: 1, ky: 1.5))
        model.apply(transformation: emptyMatrix.translation(x: 1, y: -3))
        
        print("Vertices after AT: \n\(model.getVertices())")
        print("")
        print("AT Matrix: \n\(model.getCumulativeAT())")
        
    }


}

