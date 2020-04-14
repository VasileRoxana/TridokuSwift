//
//  GameScene.swift
//  Proiect
//
//  Created by Roxana Andreea on 06/04/2020.
//  Copyright © 2020 Roxana Andreea. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreGraphics

class GameScene: SKScene {
    
    var controller: SecondViewController!
    let triangle = SKShapeNode()
    //let triangle2 = SKShapeNode()
    let triangle3 = SKShapeNode()
    
    var triangleNodes: [SKShapeNode] = Array(repeating: SKShapeNode(), count: 81)
    
    var yPath = CGFloat(40.0)
    var yPos = CGFloat(600.0)
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.systemGray5
        triangle.position = CGPoint(x: frame.midX, y: yPos)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -20.0, y: yPath - 40.0))
        path.addLine(to: CGPoint(x:20.0, y: yPath - 40.0))
        path.addLine(to:CGPoint(x:0.0, y: yPath))
        path.addLine(to:CGPoint(x:-20.0, y: yPath - 40.0))
        
        triangle.path = path.cgPath
        triangle.fillColor = UIColor.yellow
        triangle.strokeColor = UIColor.black
        addChild(triangle)
        
     /*   let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: -20.0, y: 0.0))
        path2.addLine(to: CGPoint(x:20.0, y:0.0))
        path2.addLine(to:CGPoint(x:0.0, y: -1.0 * yPath))
        path2.addLine(to:CGPoint(x:-20.0, y: 0.0))
        
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: -40.0, y: -40.0))
        path3.addLine(to: CGPoint(x:0.0, y:-40.0))
        path3.addLine(to:CGPoint(x:-20.0, y: yPath - 40))
        path3.addLine(to:CGPoint(x:-40.0, y: -40.0))

      */
        for i in 0...7 {
            createRow(_number: 3 + i * 2, _lastX: -20.0 * Double(i + 1))
            yPos = yPos - 40;
        }
        //text nodes
        let node: SKLabelNode = SKLabelNode(fontNamed: "AmericanTypeWriter-Light")
        node.text = "0"
        node.fontSize = 20
        node.fontColor = UIColor.black
        node.horizontalAlignmentMode = .center
        node.position.x = frame.midX
        node.position.y = 605.0
        
        addChild(node)
        
    }
    
    
    func createRow(_number: Int, _lastX: Double) { //_lastX NEGATIV -> coltul din stanga al triunghiului din mijloc de pe randul anterior
        var lastX = _lastX
    
        for i in 0..._number - 1 { //lastX = -20 la al doilea rand
            let path2 = UIBezierPath()
            let triangle2 = SKShapeNode()
            triangle2.position = CGPoint(x: frame.midX, y: yPos)
            
            if(i % 2 == 0) {
                path2.move(to: CGPoint(x: (lastX - 20.0), y: Double(yPath) - 80.0))
                path2.addLine(to: CGPoint(x: (lastX + 20.0), y: Double(yPath) - 80.0))
                path2.addLine(to:CGPoint(x: lastX, y: Double(yPath) - 40.0))
                path2.addLine(to:CGPoint(x:(lastX - 20.0), y: Double(yPath) - 80.0))
            }
            else { //lastX este deja crescut cu 20
                path2.move(to: CGPoint(x: (lastX - 20.0), y: Double(yPath) - 40.0))
                path2.addLine(to: CGPoint(x: (lastX + 20.0), y: Double(yPath) - 40.0))
                path2.addLine(to:CGPoint(x: lastX, y: -1.0 * Double(yPath)))
                path2.addLine(to:CGPoint(x: (lastX - 20.0), y: Double(yPath) - 40.0))
            }
            triangle2.path = path2.cgPath
            triangle2.fillColor = UIColor.yellow
            triangle2.strokeColor = UIColor.black
            triangleNodes[i] = triangle2
            addChild(triangleNodes[i])
            lastX = lastX + 20;
        }
    }
    
 
}
