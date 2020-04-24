//
//  MainMenu.swift
//  Proiect
//
//  Created by Roxana Andreea on 23/04/2020.
//  Copyright © 2020 Roxana Andreea. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenu: SKScene {

    override func didMove(to view: SKView) {
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor.systemGray5
        
        addButtons()
     }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       for t in touches {
         if t == touches.first {
            
            enumerateChildNodes(withName: "//*") { (node, stop) in
                if node.name == "easyButton" {
                    if node.contains(t.location(in: self)) {
                        ActionsManager.shared.lastBoard = nil
                        ActionsManager.shared.level = .easy
                        ActionsManager.shared.transition(self, toScene: .GameScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
                    }
                }
                else if node.name == "mediumButton" {
                    if node.contains(t.location(in: self)) {
                        ActionsManager.shared.lastBoard = nil
                        ActionsManager.shared.level = .medium
                        ActionsManager.shared.transition(self, toScene: .GameScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
                    }
                }
                else if node.name == "hardButton" {
                    if node.contains(t.location(in: self)) {
                        ActionsManager.shared.lastBoard = nil
                        ActionsManager.shared.level = .hard
                        ActionsManager.shared.transition(self, toScene: .GameScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
                    }
                }
                else if node.name == "resumeButton" {
                    if node.contains(t.location(in: self)) {
                        ActionsManager.shared.transition(self, toScene: .GameScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
                    }
                }
                
            }
        }
    }
}
    
    func addButtons() {
        
        let startGameLabel = SKLabelNode(fontNamed: "AmericanTypewriter")
        startGameLabel.text = "Start a new game? Choose your difficulty:"
        startGameLabel.fontColor = .darkGray
        startGameLabel.fontSize = 18
        startGameLabel.position = CGPoint(x: 0.5, y: 50)
        addChild(startGameLabel)
        
        let easyButton = SKSpriteNode(imageNamed: "easy")
        let mediumButton = SKSpriteNode(imageNamed: "medium")
        let hardButton = SKSpriteNode(imageNamed: "hard")
        
        easyButton.name = "easyButton"
        easyButton.position = CGPoint.zero
        easyButton.zPosition = 2
        
        mediumButton.name = "mediumButton"
        mediumButton.position = CGPoint(x: 0.5, y: -100)
        mediumButton.zPosition = 2
        
        hardButton.name = "hardButton"
        hardButton.position = CGPoint(x: 0.5, y: -200)
        hardButton.zPosition = 2
      
        addChild(easyButton)
        addChild(mediumButton)
        addChild(hardButton)
        
        if ActionsManager.shared.lastBoard != nil {
            print("resuming game")
            resumeGameButton()
        }
    }
    
    func resumeGameButton() {
        
        let resumeButton = SKSpriteNode(imageNamed: "resume")
        
        resumeButton.name = "resumeButton"
        resumeButton.position = CGPoint(x: 0.5, y: 150)
        resumeButton.zPosition = 2
        
        addChild(resumeButton)
    }
}
