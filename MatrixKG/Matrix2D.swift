//
//  Matrix2D.swift
//  MatrixKG
//
//  Created by Захар  Сегал on 18.11.2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation

class Model2D {
    
    // MARK: Private Properties:
    private var Vertices: Matrix
    private var Edges: Matrix
    private var CumulativeAT: Matrix
    private var InitialVertices: Matrix
    
    // MARK: Inits:
    public init (vertices: Matrix, edges: Matrix) {
        self.Vertices = vertices
        self.Edges = edges
        self.InitialVertices = vertices
        let m = Matrix(numberOfRows: 0, numberOfCols: 0, list: [Double]())
        self.CumulativeAT = m.identity()
    }
    
    // MARK: Getters:
    func getVertices() -> Matrix {
        return Vertices
    }
    
    func getEdges() -> Matrix {
        return Edges
    }
    
    func getCumulativeAT() -> Matrix {
        return CumulativeAT
    }
    
    // MARK: Public Funcs:
    func getVertexX(xNumber: Int) -> Double {
        return Vertices[1,xNumber]/Vertices[3,xNumber]
    }
    
    func getVertexY(yNumber: Int) -> Double {
        return Vertices[2,yNumber]/Vertices[3,yNumber]
    }
    
    func apply(transformation: Matrix) {
        CumulativeAT = transformation * CumulativeAT
        Vertices = CumulativeAT * InitialVertices
    }
}
