//
//  AffineTransforms.swift
//  MatrixKG
//
//  Created by Захар  Сегал on 02.12.2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation

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

func rotation(t: Double) -> Matrix {
    let phi = t *  3.1415926536 / 180
    let list:[Double] = [
        cos(phi), -sin(phi), 0,
        sin(phi), cos(phi), 0,
        0, 0, 1
    ]
    return  Matrix(size: 3, list: list)
}

func rotation(phi: Double, x: Double, y: Double) -> Matrix {
    return translation(x: x, y: y) * rotation(t: phi) * translation(x: -x, y: -y)
}

func mapping(x1: Double, y1:Double, x2: Double, y2: Double) -> Matrix {
    let x = x2 - x1
    let y = y2 - y1
    return translation(x: x1, y: y1) * rotation(c: x, s: y) * mappingX() * rotation(c: x, s: -y) * translation(x: -x1, y: -y1)
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

func rotation(c: Double, s: Double) -> Matrix {
    //let doubleC = Double(c), doubleS = Double(s)
    let square = sqrt(c*c+s*s)
    let cosC = c/square
    let sinS = s/square
    let list:[Double] = [
        cosC, -sinS, 0,
        sinS, cosC, 0,
        0, 0, 1
    ]
    return Matrix(size: 3, list: list)
}
