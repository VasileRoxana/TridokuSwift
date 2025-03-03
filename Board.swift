//
//  Board.swift
//  Proiect
//
//  Created by Roxana Andreea on 18/04/2020.
//  Copyright © 2020 Roxana Andreea. All rights reserved.
//

import Foundation

enum Level {
    case easy
    case medium
    case hard
}

class Board {
    
    let leftOuterLeg = [0, 1, 4, 9, 16, 25, 36, 49, 64]
    let rightOuterLeg = [0, 3, 8, 15, 24, 35, 48, 63, 80]
    let bottomOuterLeg = [64, 66, 68, 70, 72, 74, 76, 78, 80]
    let leftInnerLeg = [16, 26, 27, 39, 40, 54, 55, 71, 72]
    let rightInnerLeg = [24, 34, 33, 45, 44, 58, 57, 73, 72]
    let topInnerLeg = [16, 17, 18, 19, 20, 21, 22, 23, 24]
    
    let bigTriangles = [[0, 1, 2, 3, 4, 5, 6, 7, 8],
                        [9, 16, 17, 18, 25, 26, 27, 28, 29],
                        [10, 11, 12, 13, 14, 19, 20, 21, 30],
                        [15, 22, 23, 24, 31, 32, 33, 34, 35],
                        [36, 49, 50, 51, 64, 65, 66, 67, 68],
                        [37, 38, 39, 40, 41, 52, 53, 54, 69],
                        [42, 55, 56, 57, 70, 71, 72, 73, 74],
                        [43, 44, 45, 46, 47, 58, 59, 60, 75],
                        [48, 61, 62, 63, 76, 77, 78, 79, 80]]
    enum State {
        case correct
        case incorrect
        case notset
    }
    
    var values: [Int]
    var correct: [State]
    var canModify: [Bool]
    
    init() {
        values = Array(repeating: 0, count: 81)
        correct = Array(repeating: .notset, count: 81)
        canModify = Array(repeating: true, count: 81)
    }
    
    init(board: [Int]) {
        values = Array(repeating: 0, count: 81)
        correct = Array(repeating: .notset, count: 81)
        canModify = Array(repeating: true, count: 81)
        parseBoard(board: board)
    }
    
    convenience init(_ level: Level) {
        let boardGenerator = BoardGenerator()
        let board = boardGenerator.generateBoard(_level: (level))
        self.init(board: board)
        
        for i in 0...80 {
            if board[i] != 0 {
                canModify[i] = false
            }
        }
    }
    
    func getValue(pos: Int) -> Int {
        return values[pos]
    }
   
    func isValueCorrect(number: Int, pos: Int) -> State {
        
        if outerLegsOK(number: number, pos: pos) == false {
            return .incorrect
        }
        
        if innerLegsOK(number: number, pos: pos) == false {
            return .incorrect
        }
        
        if bigTriangleOK(number: number, pos: pos) == false {
               return .incorrect
        }
        
        if neighboursOK(number: number, pos: pos) == false {
               return .incorrect
        }
        
        return .correct
    }
   
    func parseBoard(board: [Int]) {
    
        values = board
    }
    
    func writeValue(number: Int, pos: Int) -> Bool {
        
        //check if the triangle can be modified
        if !canModify[pos] {
            return false
        }
        //check if the number is alteady written
        else if values[pos] == number {
            return false
        }
        //write the value in the values array and its correctness in the correct array for checking later
        else {
            let state = isValueCorrect(number: number, pos: pos)
            correct[pos] = state
            values[pos] = number
            return true
        }
    }
    
    func finishedGame() -> Bool {
        
        if !values.contains(0) {
            if !correct.contains(.incorrect) {
                return true
            }
        }
        return false
    }
    
    ////////////////////////////////////////////////////////////////////////////////////// / /
    // FUNCTIONS THAT CHECK MOVES CORECTNESS //
    ////////////////////////////////////////////////////////////////////////////////////// / /
    
    //check if the selected triangle is on one of the outer legs
    //check the values on it if true
    func outerLegsOK(number: Int, pos: Int) -> Bool {
        var result = true
        
        if leftOuterLeg.contains(pos) && result == true {
            
            for i in 0...8 {
                if values[leftOuterLeg[i]] == number {
                    result = false
                    break
                }
            }
        }
            
        if rightOuterLeg.contains(pos) && result == true{

            for i in 0...8 {
                if values[rightOuterLeg[i]] == number {
                    result = false
                    break
                }
            }
        }
        
        if bottomOuterLeg.contains(pos) && result == true {
         
            for i in 0...8 {
                if values[bottomOuterLeg[i]] == number {
                    result = false
                    break
                }
            }
        }
        
        return result
    }
    
    //check if the selected triangle is on one of the inner legs
    //check the values on it if true
    func innerLegsOK(number: Int, pos: Int) -> Bool {
        
        if leftInnerLeg.contains(pos) {
            
            for i in 0...8 {
                if values[leftInnerLeg[i]] == number {
                    return false
                }
            }
        }
        
        if rightInnerLeg.contains(pos) {
            
            for i in 0...8 {
                if values[rightInnerLeg[i]] == number {
                    return false
                }
            }
        }
        
        if topInnerLeg.contains(pos) {
            
            for i in 0...8 {
                if values[topInnerLeg[i]] == number {
                    return false
                }
            }
        }
        return true
    }
    
    func bigTriangleOK(number: Int, pos: Int) -> Bool {
        
        var triangleNumber: Int
        triangleNumber = 0
        
        //find out in what triangle we're trying to put the number
        for i in 0...8 {
            if bigTriangles[i].contains(pos) {
                triangleNumber = i
                break
            }
        }
        
       //check if the number already exists in the triangle
        for j in 0...8 {
            if number == values[bigTriangles[triangleNumber][j]] {
                return false
            }
        }
        
        return true
    }
    
    func getRow(pos: Int) -> Int {
        
        if pos == 0 {
            return 0
        }
        else if pos >= 1 && pos <= 3 {
            return 1
        }
        else if pos >= 4 && pos <= 8 {
            return 2
        }
        else if pos >= 9 && pos <= 15 {
            return 3
        }
        else if pos >= 16 && pos <= 24 {
            return 4
        }
        else if pos >= 25 && pos <= 35 {
            return 5
        }
        else if pos >= 36 && pos <= 48 {
            return 6
        }
        else if pos >= 49 && pos <= 63 {
            return 7
        }
        else { //pos >= 64 && pos <= 80
            return 8
        }
    }
    
    func neighboursOK(number: Int, pos: Int) -> Bool {
        
        let row = getRow(pos: pos)
        //get the number of elements on the row
        let rowElements = 3 + 2 * (row - 1)
        
        var result: Bool
        result = true
        
        switch row {
        case 0:
            if number == values[1] || number == values [2] || number == values [3] {
                result = false
            }
        case 1:
            if pos == 1 {
                if number == values[0] || number == values [2] || number == values [3]
                || number == values[4] || number == values [5] || number == values [6] || number == values [7] {
                    result = false
                }
            }
            else if pos == 2 {
                if number == values[0] || number == values [1] || number == values [3]
                || number == values [5] || number == values [6] || number == values [7] {
                    result = false
                }
            }
            if pos == 3 {
                if number == values[0] || number == values [1] || number == values [2]
                || number == values [5] || number == values [6] || number == values [7] || number == values[8] {
                    result = false
                }
            }
        case 2:
            if pos == 4 {
                result = checkFirstFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 5 {
                result = checkSecondFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 7 {
                result = checkSecondToLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 8 {
                result = checkLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else {
                result = checkAllNeighbours(pos: pos, row: rowElements, number: number)
            }
        case 3:
            if pos == 9 {
                result = checkFirstFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 10 {
                result = checkSecondFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 14 {
                result = checkSecondToLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 15 {
                result = checkLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else {
                result = checkAllNeighbours(pos: pos, row: rowElements, number: number)
            }
        case 4:
            if pos == 16 {
                result = checkFirstFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 17 {
                result = checkSecondFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 23 {
                result = checkSecondToLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 24 {
                result = checkLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else {
                result = checkAllNeighbours(pos: pos, row: rowElements, number: number)
            }
        case 5:
            if pos == 25 {
                result = checkFirstFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 26 {
                result = checkSecondFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 34 {
                result = checkSecondToLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 35 {
                result = checkLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else {
                result = checkAllNeighbours(pos: pos, row: rowElements, number: number)
            }
        case 6:
            if pos == 36 {
                result = checkFirstFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 37 {
                result = checkSecondFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 47 {
                result = checkSecondToLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 48 {
                result = checkLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else {
                result = checkAllNeighbours(pos: pos, row: rowElements, number: number)
            }
        case 7:
            if pos == 49 {
                result = checkFirstFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 50 {
                result = checkSecondFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 62 {
                result = checkSecondToLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else if pos == 63 {
                result = checkLastFromRow(pos: pos, row: rowElements, number: number)
            }
            else {
                result = checkAllNeighbours(pos: pos, row: rowElements, number: number)
            }
        case 8:
            if pos == 64 {
                    if number == values[49] || number == values [65] || number == values [66] {
                        result = false
                    }
                }
            else if pos == 65 {
                    if number == values[64] || number == values [66] || number == values [49]
                    || number == values[50] || number == values [51] || number == values [67] {
                        result = false
                    }
                }
            else if pos == 79 {
                if number == values[80] || number == values [78] || number == values [63]
                || number == values[62] || number == values [61] || number == values [77] {
                    result = false
                }
            }
            else if pos == 80 {
                if number == values[78] || number == values [79] || number == values [63]{
                    result = false
                }
            }
            else {
                if pos % 2 == 0 {
                    if number == values[pos - 1] || number == values [pos + 1]
                    || number == values [pos - 2] || number == values [pos + 2]
                    || number == values [pos - 17] || number == values [pos - 16] || number == values[pos - 15] {
                        result = false
                    }
                }
                else {
                    if number == values[pos - 1] || number == values [pos + 1]
                    || number == values [pos - 2] || number == values [pos + 2]
                    || number == values [pos - 18] || number == values [pos - 17]
                    || number == values[pos - 16] || number == values[pos - 15] || number == values[pos - 14] {
                        result = false
                    }
                }
            }
        default:
            result = true
        }
        
        return result
    }
    
    func checkFirstFromRow(pos: Int, row: Int, number: Int) -> Bool{
        
        if number == values[pos + row] || number == values [pos + row + 1]
            || number == values [pos + row + 2] || number == values [pos + row + 3]
            || number == values [pos + 1] || number == values [pos + 2]
            || number == values [pos - row + 2] {
            return false
        }
        return true
    }
    
    func checkSecondFromRow(pos: Int, row: Int, number: Int) -> Bool{
        
        if number == values[pos + row] || number == values [pos + row + 1] || number == values [pos + row + 2]
            || number == values [pos + 1] || number == values [pos + 2] || number == values [pos - 1]
            || number == values [pos - row + 1] || number == values [pos - row + 2] || number == values [pos - row + 3]{
            return false
        }
        return true
    }
    
    func checkLastFromRow(pos: Int, row: Int, number: Int) -> Bool{
           
           if number == values[pos - 1] || number == values [pos - 2]
               || number == values [pos + row + 1] || number == values [pos + row + 2]
               || number == values [pos + row] || number == values [pos + row - 1]
               || number == values [pos - row] {
               return false
           }
           return true
       }
    
    func checkSecondToLastFromRow(pos: Int, row: Int, number: Int) -> Bool{
        
        if number == values[pos - 1] || number == values [pos - 2] || number == values [pos + 1]
            || number == values [pos + row + 1] || number == values [pos + row + 2] || number == values [pos + row]
            || number == values [pos - row - 1] || number == values [pos - row + 1] || number == values [pos - row] {
            return false
        }
        return true
    }
    
    func checkAllNeighbours (pos: Int, row: Int, number: Int) -> Bool{
        
        if number == values[pos - 1] || number == values [pos - 2]
        || number == values [pos + 1] || number == values [pos + 2]
        || number == values [pos + row + 1] || number == values [pos + row + 2] || number == values [pos + row]
        || number == values [pos - row + 1] || number == values [pos - row] || number == values [pos - row - 1]
        || number == values [pos - row + 2] || number == values [pos - row + 3] {
            return false
        }
        return true
    }
}
    

