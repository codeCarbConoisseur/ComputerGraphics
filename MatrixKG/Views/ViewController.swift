//
//  ViewController.swift
//  MatrixKG
//
//  Created by Захар  Сегал on 17.11.2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit
import CoreGraphics

enum ArrayType {
    case vertices
    case edges
}


class ViewController: UIViewController {
    
    // MARK: Properties:
    
    private var verticesRow: Int = Int()
    private var verticesCols: Int = Int()
    private var edgesRow: Int = Int()
    private var edgesCols: Int = Int()
    private var model: Model2D?
    private var vertices: [Double] = {
        let array = Array(repeating: Double(), count: 15)
        return array
    }()
    private var edges: [Double] = {
        let array = Array(repeating: Double(), count: 10)
        return array
    }()
    //    let secondArray:[Double] = [15,10,5,0,15,10]
    //    let thirdArray:[Double] = [10,20,10,20,10,20]
    
    
    // MARK: Outlets:
    @IBOutlet weak var myTabBar: UITabBar!
    @IBOutlet weak var firstTabBarItem: UITabBarItem!
    @IBOutlet weak var secondTabBarItem: UITabBarItem!
    @IBOutlet weak var thirdTabBarItem: UITabBarItem!
    @IBOutlet weak var fourthTabBarItem: UITabBarItem!
    @IBOutlet weak var fifthTabBarItem: UITabBarItem!
    let myTabBarItems: [UITabBarItem] = [
        UITabBarItem(title: "left", image: UIImage(named: "left"), selectedImage: nil),
        UITabBarItem(title: "right", image: UIImage(named: "right"), selectedImage: nil),
        UITabBarItem(title: "up", image: UIImage(named: "up"), selectedImage: nil),
        UITabBarItem(title: "down", image: UIImage(named: "down"), selectedImage: nil),
        UITabBarItem(title: "spin", image: UIImage(named: "spinLeft"), selectedImage: nil)
        
    ]
    var myDrawingView: MyDrawingView = {
        let view = MyDrawingView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTabBar()
        readFromFile(resource: "Vertices", ofType: "txt", arrayType: .vertices)
        readFromFile(resource: "Edges", ofType: "txt", arrayType: .edges)
        let firstMatrix = Matrix(numberOfRows: verticesRow, numberOfCols: verticesCols, list: vertices)
        let edgesMatrix = Matrix(numberOfRows: edgesRow, numberOfCols: edgesCols, list: edges)
        let model = Model2D(vertices: firstMatrix, edges: edgesMatrix)
        self.model = model
        print("Vertices: \n\(model.getVertices())")
        print("Edges: \n\(model.getEdges())")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let model = model else {
            fatalError("\n MODEL IS NIL \n")
        }
        myDrawingView.model = model
    }
    // MARK: CONFIGURE VIEW
    private func configureTabBar() {
        myTabBar.delegate = self
        myTabBar.items = myTabBarItems
        
    }
    
    private func configureView() {
        self.view.addSubview(myDrawingView)
        myDrawingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myDrawingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        myDrawingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        myDrawingView.bottomAnchor.constraint(equalTo: myTabBar.topAnchor).isActive = true
    }
    
    // MARK: Read From File
    private func readFromFile(resource: String, ofType: String, arrayType: ArrayType) {
        var text: [String] = [String]()
        var stringArray: [String] = [String]()
        if let path = Bundle.main.path(forResource: resource, ofType: ofType) {
            if let text = try? String(contentsOfFile: path){
                stringArray = text.components(separatedBy: "\n")
            }
        }
        for i in 0..<stringArray.count {
            if i == 0 {
                if arrayType == .vertices {
                    verticesRow = Int(stringArray[i])!
                } else {
                    edgesRow = Int(stringArray[i])!
                }
            } else if i == 1 {
                if arrayType == .vertices {
                    verticesCols = Int(stringArray[i])!
                } else {
                    edgesCols = Int(stringArray[i])!
                }
            } else {
                text += stringArray[i].components(separatedBy: " ")
            }
        }
        var k: Int = 0
        for number in text {
            if let doubleNumber = Double(number) {
                if arrayType == .vertices {
                    vertices[k] = doubleNumber
                } else {
                    edges[k] = doubleNumber
                }
            }
            k+=1
        }
        if arrayType == .vertices {
            print(vertices)
        } else {
            print(edges)
        }
    }
    
    
    
}

extension ViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar == myTabBar {
            guard let model =  self.model else {
                fatalError("\n MODEL IS NIL \n")
            }
            switch item {
            case tabBar.items?[0]:
                model.apply(transformation: translation(x: -1, y: 0))
                print("LEFT")
            case tabBar.items?[1]:
                model.apply(transformation: translation(x: 1, y: 0))
                print("RIGHT")
            case tabBar.items?[2]:
                model.apply(transformation: translation(x: 0, y: 1))
                print("UP")
            case tabBar.items?[3]:
                model.apply(transformation: rotation(t: 5))
                //model.apply(transformation: translation(x: 0, y: -1))
                print("DOWN")
            case tabBar.items?[4]:
                model.apply(transformation: mapping(x1: model.getVertexX(xNumber: 0), y1: model.getVertexY(yNumber: 0), x2: model.getVertexX(xNumber: 4), y2: model.getVertexY(yNumber: 4)))
                print("SPIN LEFT")
            default:
                print("DEFAULT")
            }
            myDrawingView.model = model
        }
        
    }
}

