//
//  ActionsManager.swift
//  Proiect
//
//  Created by Roxana Andreea on 23/04/2020.
//  Copyright © 2020 Roxana Andreea. All rights reserved.
//

import SpriteKit


// this is a singleton class that holds a bunch of functions so we can access them from any class in the project
class ActionsManager {
    
    enum SceneType {
       case MainMenu, GameScene
     }
    
    private init() {}
    
    static let shared = ActionsManager()
    var level = Level.easy
    var lastBoard: Board? = nil
    
    public func launch() {
        firstLaunch()
    }
      
    private func firstLaunch() {
        
    //check if the game is launched for the first time ever
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            print("First launch")
          
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            UserDefaults.standard.synchronize()
        }
    }
    
    //makes the transitions between scenes
    func transition(_ fromScene: SKScene, toScene: SceneType, transition: SKTransition? = nil ) {
        //check if we have a scene to transition to
        guard let scene = getScene(toScene) else { return }
        
        //check if we have a transition type, if so we use it
        if let transition = transition {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene, transition: transition)
        } else {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene)
        }
    }
    
    func eraseGameFromMemory() {
        UserDefaults.standard.removeObject(forKey: "values")
        UserDefaults.standard.removeObject(forKey: "correct")
        UserDefaults.standard.removeObject(forKey: "canModify")
    }
    
    //gets the type of the actual scene
    func getScene(_ sceneType: SceneType) -> SKScene? {
        switch sceneType {
            case SceneType.MainMenu:
                return MainMenu(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            case SceneType.GameScene:
                return GameScene(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        }
    }
    
    //function that saves the board when going back to main menu
    func rememberBoard(board: Board) {
        lastBoard = board
    }
    
    //generates an alert and presents it over the actual scene
    func showAlert(on scene: SKScene, title: String, message: String, preferredStyle: UIAlertController.Style, actions: [UIAlertAction], animated: Bool, completion: ( () -> Swift.Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            alert.addAction(action)
        }
        
        scene.view?.window?.rootViewController?.present(alert, animated: animated, completion: completion)
    }
}
