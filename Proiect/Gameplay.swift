//
//  Gameplay.swift
//  Proiect
//
//  Created by Roxana Andreea on 23/04/2020.
//  Copyright © 2020 Roxana Andreea. All rights reserved.
//

//
//  Gameplay.swift
//  Proiect
//
//  Created by Roxana Andreea on 23/04/2020.
//  Copyright © 2020 Roxana Andreea. All rights reserved.
//

import UIKit
import SpriteKit

class Gameplay: SKScene {
  override func didMove(to view: SKView) {
    print("Inside Gameplay")
    backgroundColor = .cyan
  }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print ("inside touches began gameplay")
        for touch in touches {
            if touch == touches.first {
        print("Going to Main Menu scene")
        ActionsManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
    }
  }
}
