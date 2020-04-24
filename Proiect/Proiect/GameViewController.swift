//
//  GameViewController.swift
//  Proiect
//
//  Created by Roxana Andreea on 06/04/2020.
//  Copyright © 2020 Roxana Andreea. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    let skView: SKView = {
       let view = SKView()
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
     }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(skView)
          
        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        let scene = MainMenu(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
    }
    
  ////////////////// codul meu /////////
 /*   @IBAction func pressedStartButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "second") as! SecondViewController
       // present(controller, animated: false, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
 */
}

