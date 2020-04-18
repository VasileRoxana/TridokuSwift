//
//  GameViewController.swift
//  Proiect
//
//  Created by Roxana Andreea on 06/04/2020.
//  Copyright © 2020 Roxana Andreea. All rights reserved.
//

import UIKit
import SpriteKit
//import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func pressedStartButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "second") as! SecondViewController
       // present(controller, animated: false, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}

