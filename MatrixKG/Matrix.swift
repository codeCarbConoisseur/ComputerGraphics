//
//  Matrix.swift
//  MatrixKG
//
//  Created by Захар  Сегал on 17.11.2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation

postfix operator ^
typealias Cell = Double

// MARK: Public func in protocol:
protocol MatrixProtocol: class {
    func identity() -> Matrix
    func rotation(t: Int) -> Matrix
    func rotation(c: Int, s: Int) -> Matrix
    func scaling(kx: Double, ky: Double) -> Matrix
    func mappingX() -> Matrix
    func mappingY() -> Matrix
    func translation(x: Double, y:Double) -> Matrix
}

class Matrix: CustomStringConvertible {
    
    // MARK: PrivateProperties:
    private var rows, cols: Int
    private var size: Int?
    private var cells: [[Cell]]
    
    
    // MARK: PublicProperties:
    var description: String {
        var dsc = ""
        for row in 0..<rows {
            for col in 0..<cols {
                let s = String(self[row,col])
                dsc += s + " "
            }
            dsc += "\n"
        }
        return dsc
    }
    
    // MARK: Inits:
    public convenience init (numberOfRows: Int, numberOfCols: Int, list: [Double]) {
        self.init(numberOfRows: numberOfRows, numberOfCols: numberOfCols)
        var index: Int = 0
        for i in 0..<numberOfRows {
            for j in 0..<numberOfCols {
                cells[i][j] = list[index]
                index+=1
            }
        }
    }
    
    public convenience init (size: Int, list: [Double]) {
        self.init(size: size)
        var index: Int = 0
        for i in 0..<size {
            for j in 0..<size {
                cells[i][j] = list[index]
                index+=1
            }
        }
    }
    
    private init (numberOfRows: Int, numberOfCols: Int) {
        self.rows = numberOfRows
        self.cols = numberOfCols
        let grid = Array(repeating: [Cell](repeating: Cell(), count: numberOfCols), count: numberOfRows)
        self.cells = grid
    }
    
    private init (numberOfRows: Int, numberOfCols: Int, grid: [[Cell]]) {
        self.rows = numberOfRows
        self.cols = numberOfCols
        self.cells = grid
    }
    
    private init (size: Int) {
        self.rows = size
        self.cols = size
        self.size = size
        let grid = Array(repeating: [Cell](repeating: Cell(), count: size), count: size)
        self.cells = grid
    }
    
    
    // MARK: Arithmetic:
    static public func + (left: Matrix, right: Matrix) -> Matrix {
        precondition(left.rows == right.rows && left.cols == right.cols, "Matrix cannot be summed")
        for i in 0..<left.rows {
            for j in 0..<left.cols {
                left.cells[i][j] += right.cells[i][j]
            }
        }
        return left
    }
    
    static public func - (left: Matrix, right: Matrix) -> Matrix {
        precondition(left.rows == right.rows && left.cols == right.cols)
        for i in 0..<left.rows {
            for j in 0..<left.cols {
                left.cells[i][j] -= right.cells[i][j]
            }
        }
        return left
    }
    
    static postfix func ^(m:Matrix) -> Matrix {
        let t = Matrix(numberOfRows: m.cols, numberOfCols: m.rows)
        for row in 0..<m.rows {
            for col in 0..<m.cols {
                t[col,row] = m[row,col]
            }
        }
        return t
    }
    
    static public func * (left:Matrix, right:Matrix) -> Matrix {
        let left = left.copy()
        let right = right.copy()
        
        precondition(left.cols == right.rows, "Matrices cannot be multipied")
        let dot = Matrix(numberOfRows: left.rows, numberOfCols: right.cols)
        
        for i in 0..<left.rows {
            for j in 0..<right.cols {
                var sum: Double = 0
                for k in 0..<right.rows {
                    sum += left.cells[i][k] * right.cells[k][j]
                }
                dot.cells[i][j] = sum
            }
        }
        return dot
    }
    
    func copy(with zone: NSZone? = nil) -> Matrix {
        let copy = Matrix(numberOfRows: self.rows, numberOfCols: self.cols, grid: self.cells)
        return copy
    }
    
}


// MARK: Public Funcs:
extension Matrix: MatrixProtocol {
    
    
    func translation(x: Double, y:Double) -> Matrix {
        let list:[Double] = [
            1,0,x,
            0,1,y,
            0,0,1
        ]
        return Matrix(size: 3, list: list)
    }
    
    func identity() -> Matrix {
        let list:[Double] = [
            1,0,0,
            0,1,0,
            0,0,1
        ]
        let matrix = Matrix(size: 3, list: list)
        return matrix
    }
    
    func rotation(t: Int) -> Matrix {
        let list:[Double] = [
            cos(Double(t)), -sin(Double(t)), 0,
            sin(Double(t)), cos(Double(t)), 0,
            0, 0, 1
        ]
        return  Matrix(size: 3, list: list)
    }
    
    func rotation(c: Int, s: Int) -> Matrix {
        let doubleC = Double(c), doubleS = Double(s)
        let square = sqrt(doubleC*doubleC+doubleS*doubleS)
        let cosC = doubleC/square
        let sinS = doubleS/square
        let list:[Double] = [
            cosC, -sinS, 0,
            sinS, cosC, 0,
            0, 0, 1
        ]
        return Matrix(size: 3, list: list)
    }
    
    func scaling(kx: Double, ky: Double) -> Matrix {
        let list:[Double] = [
            kx, 0, 0,
            0, ky, 0,
            0, 0, 1
        ]
        return Matrix(size: 3, list: list)
    }
    
    func mappingX() -> Matrix{
        let list:[Double] = [
            1,0,0,
            0,-1,0,
            0,0,1
        ]
        return Matrix(size: 3, list: list)
    }
    
    func mappingY() -> Matrix{
        let list:[Double] = [
            -1,0,0,
            0,1,0,
            0,0,1
        ]
        return Matrix(size: 3, list: list)
    }
    
}

extension Matrix {
    // MARK: Subscripts:
    subscript(row: Int, col: Int) -> Double {
        get {
            return cells[row][col]
        }
        
        set {
            self.cells[row][col] = newValue
        }
    }
}

