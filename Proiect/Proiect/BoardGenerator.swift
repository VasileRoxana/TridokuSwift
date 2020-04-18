//
//  BoardGenerator.swift
//  Proiect
//
//  Created by Roxana Andreea on 18/04/2020.
//  Copyright © 2020 Roxana Andreea. All rights reserved.
//

import Foundation

class BoardGenerator {
    
                  let easy = [[ 0,
                            0, 4, 0,
                         7, 0, 0, 6, 0,
                      4, 3, 0, 0, 1, 2, 7,
                   0, 7, 0, 9, 0, 4, 3, 8, 2,
                6, 9, 0, 2, 0, 0, 1, 5, 9, 4, 0,
             9, 1, 2, 7, 5, 0, 9, 0, 7, 0, 5, 8, 4,
          2, 6, 7, 0, 9, 0, 2, 3, 8, 1, 0, 0, 1, 0, 8,
       3, 1, 8, 0, 0, 6, 0, 0, 6, 0, 7, 4, 2, 0, 0, 3, 0]]
    
                let medium = [[4,
                           0, 0, 0,
                        7, 0, 0, 8, 1,
                     6, 2, 3, 0, 0, 7, 6,
                  0, 0, 7, 8, 0, 1, 0, 4, 2,
               0, 0, 8, 0, 4, 0, 0, 7, 1, 0, 8,
            0, 9, 0, 0, 7, 0, 0, 3, 8, 0, 7, 0, 0,
         2, 6, 7, 1, 0, 0, 0, 5, 7, 0, 1, 4, 0, 1, 3,
      0, 4, 1, 5, 0, 4, 0, 1, 0, 0, 0, 0, 0, 2, 5, 0, 0]]
    
                let hard = [[ 8,
                          6, 0, 1,
                       0, 0, 5, 0, 7,
                    0, 0, 7, 0, 1, 0, 0,
                 1, 0, 2, 9, 0, 5, 8, 0, 4,
              0, 9, 0, 0, 7, 0, 0, 0, 0, 9, 6,
           0, 0, 7, 5, 0, 0, 5, 0, 2, 0, 1, 0, 9,
        3, 6, 5, 9, 0, 0, 8, 0, 1, 8, 0, 5, 2, 8, 0,
     7, 4, 0, 0, 0, 6, 2, 7, 0, 0, 0, 3, 0, 0, 6, 4, 0]]
    
    func generateBoard(_level: Level) -> [Int]{
       // let rand = Int.random(in: 0...4)
        let rand = 0
        switch _level {
        case .easy:
            return easy[rand]
        
        case .medium:
            return medium[rand]
        
        case .hard:
            return hard[rand]
        }
    }
}
