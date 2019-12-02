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
        self.CumulativeAT = identity()
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
        return Vertices[0,xNumber]/Vertices[2,xNumber]
    }
    
    func getVertexY(yNumber: Int) -> Double {
        return Vertices[1,yNumber]/Vertices[2,yNumber]
    }
    
    func apply(transformation: Matrix) {
        CumulativeAT = transformation * CumulativeAT
        Vertices = CumulativeAT * InitialVertices
    }
}
