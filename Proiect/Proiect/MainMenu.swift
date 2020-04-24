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
                        
                        if ActionsManager.shared.lastBoard != nil {
                            self.showAlert(level: .easy)
                        }
                        else {
                            self.newGame(level: .easy)
                        }
                    }
                }
                else if node.name == "mediumButton" {
                    if node.contains(t.location(in: self)) {
                        
                        if ActionsManager.shared.lastBoard != nil {
                            self.showAlert(level: .medium)
                        }
                        else {
                            self.newGame(level: .medium)
                        }
                    }
                }
                else if node.name == "hardButton" {
                    if node.contains(t.location(in: self)) {
                        
                        if ActionsManager.shared.lastBoard != nil {
                            self.showAlert(level: .hard)
                        }
                        else {
                            self.newGame(level: .hard)
                        }
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
    
    func showAlert(level: Level) {
           
           let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {(result) in
               self.newGame(level: level)})
           let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
           
           ActionsManager.shared.showAlert(on: self, title: "Start new game", message: "If you start a new game you'll lose the saved one. Proceed?", preferredStyle: .alert, actions: [yesAction, noAction], animated: true) {
               print("Showed alert")
           }
       }
    
    func newGame(level: Level) {
        ActionsManager.shared.lastBoard = nil
        ActionsManager.shared.level = level
        ActionsManager.shared.transition(self, toScene: .GameScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
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
