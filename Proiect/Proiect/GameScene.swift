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
    
    var triangleNodes: [SKShapeNode] = Array(repeating: SKShapeNode(), count: 81)
    var textNodes: [SKLabelNode] = Array(repeating: SKLabelNode(), count: 81)
    var buttons: [[SKLabelNode]] = Array(repeating: Array(repeating: SKLabelNode(), count: 3), count: 3)
    let leftOuterLeg = [0, 1, 4, 9, 16, 25, 36, 49, 64]
    let rightOuterLeg = [0, 3, 8, 15, 24, 35, 48, 63, 80]
    let bottomOuterLeg = [64, 66, 68, 70, 72, 74, 76, 78, 80]
    let leftInnerLeg = [16, 26, 27, 39, 40, 54, 55, 71, 72]
    let rightInnerLeg = [24, 34, 33, 45, 44, 58, 57, 73, 72]
    let topInnerLeg = [16, 17, 18, 19, 20, 21, 22, 23, 24]
    
    var yPath = CGFloat(40.0)
    var yPos = CGFloat(600.0)
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.systemGray5
        
        //first triangle node
        triangle.position = CGPoint(x: frame.midX, y: yPos)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -20.0, y: yPath - 40.0))
        path.addLine(to: CGPoint(x:20.0, y: yPath - 40.0))
        path.addLine(to:CGPoint(x:0.0, y: yPath))
        path.addLine(to:CGPoint(x:-20.0, y: yPath - 40.0))
        
        triangle.path = path.cgPath
        triangle.fillColor = UIColor.yellow
        triangle.strokeColor = UIColor.black
        triangleNodes[0] = triangle
        addChild(triangle)
        
        //first text node
        let node = SKLabelNode(fontNamed: "ArialMT")
       // node.text = "0"
        node.fontSize = 20
        node.fontColor = UIColor.black
        node.horizontalAlignmentMode = .center
        node.position.x = frame.midX
        node.position.y = yPos + 5.0
        textNodes[0] = node
        addChild(node)
        
        for i in 0...7 {
            createRow(_number: 3 + i * 2, _lastX: -20.0 * Double(i + 1))
            yPos = yPos - 40;
        }
        
        
        outlineTriangles()
        //color the inner and outer triangles legs
        colorLegs()
        //create the buttons
        createButtons()
    }
    
    var count = 1;
    func createRow(_number: Int, _lastX: Double) { //_lastX NEGATIV -> coltul din stanga al triunghiului din mijloc de pe randul anterior
        var lastX = _lastX
        for i in 0..._number - 1 { //lastX = -20 la al doilea rand
            let path2 = UIBezierPath()
            let triangle2 = SKShapeNode()
            triangle2.position = CGPoint(x: frame.midX, y: yPos)
            
            let node = SKLabelNode(fontNamed: "ArialMT")
       //     node.text = String(count)
            node.fontSize = 15
            node.fontColor = UIColor.black
            node.horizontalAlignmentMode = .center
            node.position.x = frame.midX + CGFloat(lastX)
            
            if(i % 2 == 0) {
                path2.move(to: CGPoint(x: (lastX - 20.0), y: Double(yPath) - 80.0))
                path2.addLine(to: CGPoint(x: (lastX + 20.0), y: Double(yPath) - 80.0))
                path2.addLine(to:CGPoint(x: lastX, y: Double(yPath) - 40.0))
                path2.addLine(to:CGPoint(x:(lastX - 20.0), y: Double(yPath) - 80.0))
                node.position.y = yPos - yPath + 10.0
            }
            else { //lastX este deja crescut cu 20
                path2.move(to: CGPoint(x: (lastX - 20.0), y: Double(yPath) - 40.0))
                path2.addLine(to: CGPoint(x: (lastX + 20.0), y: Double(yPath) - 40.0))
                path2.addLine(to:CGPoint(x: lastX, y: -1.0 * Double(yPath)))
                path2.addLine(to:CGPoint(x: (lastX - 20.0), y: Double(yPath) - 40.0))
                node.position.y = yPos - yPath + 15.0
            }
            
            triangle2.path = path2.cgPath
            triangle2.fillColor = UIColor(red: 0.6235, green: 0.9569, blue: 0.8784, alpha: 1.0)
            triangle2.strokeColor = UIColor.black
            
            triangleNodes[count] = triangle2
            textNodes[count] = node
            addChild(triangleNodes[count])
            addChild(textNodes[count])
            
            count += 1
            lastX = lastX + 20;
        }
        
    }
    
    func colorLegs(){
        
        for i in 0...8 {
            triangleNodes[leftOuterLeg[i]].fillColor = UIColor(red: 0.2196, green: 0.8784, blue: 0.6235, alpha: 1.0) /* #38e09f */
            triangleNodes[rightOuterLeg[i]].fillColor = UIColor(red: 0.2196, green: 0.8784, blue: 0.6235, alpha: 1.0) /* #38e09f */
            triangleNodes[bottomOuterLeg[i]].fillColor = UIColor(red: 0.2196, green: 0.8784, blue: 0.6235, alpha: 1.0) /* #38e09f */
            
            triangleNodes[leftInnerLeg[i]].fillColor = UIColor(red: 0.2549, green: 0.8588, blue: 0.698, alpha: 1.0) /* #41dbb2 */
            triangleNodes[rightInnerLeg[i]].fillColor = UIColor(red: 0.2549, green: 0.8588, blue: 0.698, alpha: 1.0) /* #41dbb2 */
            triangleNodes[topInnerLeg[i]].fillColor = UIColor(red: 0.2549, green: 0.8588, blue: 0.698, alpha: 1.0) /* #41dbb2 */
        }
        triangleNodes[16].fillColor = UIColor(red: 0.4824, green: 0.949, blue: 0.6627, alpha: 1.0) /* #7bf2a9 */
        triangleNodes[24].fillColor = UIColor(red: 0.4824, green: 0.949, blue: 0.6627, alpha: 1.0) /* #7bf2a9 */
        triangleNodes[72].fillColor = UIColor(red: 0.4824, green: 0.949, blue: 0.6627, alpha: 1.0) /* #7bf2a9 */
        
        
    }
    
    func outlineTriangles(){
        
        let bigTriangle = SKShapeNode()
        bigTriangle.position = CGPoint(x: frame.midX, y: yPos)
        let bigPath = UIBezierPath()
        bigPath.move(to: CGPoint(x: -20.0 * 9, y: Double(yPath) - 40.0))
        bigPath.addLine(to: CGPoint(x: 20.0 * 9, y: Double(yPath) - 40.0))
        bigPath.addLine(to: CGPoint(x: 0.0, y: yPos + 80.0 ))
        bigPath.addLine(to: CGPoint(x: -20.0 * 9, y: Double(yPath) - 40.0))
        //linia mica stanga
        bigPath.addLine(to: CGPoint(x: -20.0 * 3, y: Double(yPath) - 40.0))
        bigPath.addLine(to: CGPoint(x: -20.0 * 6 , y: yPos - 160.0))
        //linia mare mijloc
        bigPath.addLine(to: CGPoint(x: 20.0 * 6 , y: yPos - 160.0))
        //linia mica dreapta
        bigPath.addLine(to: CGPoint(x: 20.0 * 3, y: Double(yPath) - 40.0))
        //linia mare stanga
        bigPath.addLine(to: CGPoint(x: -20.0 * 3, y: yPos - 40.0))
        //linia mica mijloc
        bigPath.addLine(to: CGPoint(x: 20.0 * 3, y: yPos - 40.0))
        //linia mare dreapta
         bigPath.addLine(to: CGPoint(x: -20.0 * 3, y: Double(yPath) - 40.0))
        
        bigTriangle.path = bigPath.cgPath
        bigTriangle.strokeColor = UIColor.black
        bigTriangle.lineWidth = 2.5
        addChild(bigTriangle)
        
        
    }
    
    func createButtons(){
        
        for j in 0...2 {
            for k in 0...2{
                let button = SKLabelNode(fontNamed: "ArialMT")
                button.position.y = yPos - 200.0 - CGFloat(50.0 * Double(j - 1))
                button.position.x = frame.midX + CGFloat(80.0 * Double(k - 1))
                button.fontColor = UIColor.darkGray
                button.fontSize = 45
                button.color = UIColor.red
                button.text = String(j * 3 + k + 1)
                buttons[j][k] = button
                self.addChild(buttons[j][k])
            }
        }
    }
}
