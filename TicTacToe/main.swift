//
//  main.swift
//  TicTacToe
//
//  Created by Crystal Mora on 6/10/17.
//  Copyright © 2017 Crystal Mora. All rights reserved.
//

import Foundation

print("Welcome to Crystal's Fun Tic Tac Toe Game, below are the directions on how to play!\n")
print("| x | o | x |\n --- --- ---\n| o | x |   |\n --- --- ---\n|   | o | x |\n")

var directions = "Directions: Decide who will be player One, which has X. And who will be player Two that has O. The way the board is set up there are three empty rows crossesctioned by 3 empty columns. \n So much like a traditional Tic Tac Toe board there it is a 3x3 grid. Your quest is to make a 3 in a row of your letter. This can be either horizontal, vertically, or diagnol. You enter your selection by inputing as if this were a graph. For example if you wanted to put your letter in the top right corner you would enter 1,3, or in the middle 2,2 or bottom left 3,1. First one to complete the quest wins!\n"
print(directions)

var board: [[String?]] = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]

func printBoard(){
    
    print("\n \(board[0][0] ?? " ") | \(board[0][1] ?? " ") | \(board[0][2] ?? " ") ")
    print("---*---*---")
    print(" \(board[1][0] ?? " ") | \(board[1][1] ?? " ") | \(board[1][2] ?? " ") ")
    print("---*---*---")
    print(" \(board[2][0] ?? " ") | \(board[2][1] ?? " ") | \(board[2][2] ?? " ") \n")
}

func input() -> String {
    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData
    return NSString(data: inputData, encoding: String.Encoding.utf8.rawValue)! as String
}

func processPlayerTurn(input: String, piece: String) -> Bool { //TODO change piece to enum
    let cleanedUpMove = input.replacingOccurrences(of: "\n", with: "")
    var x: Int!
    var y: Int!
    switch cleanedUpMove {
    case "1,1":
        x = 1
        y = 1
    case "1,2":
        x = 1
        y = 2
    case "1,3":
        x = 1
        y = 3
    case "2,1":
        x = 2
        y = 1
    case "2,2":
        x = 2
        y = 2
    case "2,3":
        x = 2
        y = 3
    case "3,1":
        x = 3
        y = 1
    case "3,2":
        x = 3
        y = 2
    case "3,3":
        x = 3
        y = 3
    default:
        return false
    }
    
    guard board[x-1][y-1] == nil else {
      return false
    }
    
    board[x-1][y-1] = piece
    return true
}

func didPlayerWin(board: [[String?]], piece: String) -> Bool {
    if board[0][0] == piece && board[0][1] == piece && board[0][2] == piece {
        return true
    } else if board[1][0] == piece && board[1][1] == piece && board[1][2] == piece {
        return true
    } else if board[2][0] == piece && board[2][1] == piece && board[2][2] == piece {
        return true
    } else if board[0][0] == piece && board[1][0] == piece && board[2][0] == piece {
        return true
    } else if board[0][1] == piece && board[1][1] == piece && board[2][1] == piece {
        return true
    } else if board[0][2] == piece && board[1][2] == piece && board[2][2] == piece {
        return true
    } else if board[0][0] == piece && board[1][1] == piece && board[2][2] == piece {
        return true
    } else if board[0][2] == piece && board[1][1] == piece && board[2][0] == piece {
        return true
    }
    
    return false
}

func isBoardFull(board: [[String?]]) -> Bool {
    for row in board {
        for column in row {
            if column == nil {
                return false
            }
        }
    }
    return true
}

var playerOneGo = "Player One please make your selection:\n"
var playerTwoGo = "Player Two please make your selection:\n"
var errorMessage = "You may have chosen a spot already taken, or entered your selection wrong. Please make sure you enter your move as a coordinate such as 1,3 and try again.\n"
var tiedMessage = "Wow, both players are really great and you both tied!"

while (true) {

    //tell player one to go
    print (playerOneGo)
    //take player one's input
    var playerMove = input()
    //based on that input, perform the player's move on the board
    //if player one move is wrong have them input move again, until corrected, using a while loop
    while processPlayerTurn(input: playerMove, piece: "X") == false {
        print(errorMessage)
        print(playerOneGo)
        playerMove = input()
    }
    //print board nicely
    printBoard()
    //Check to see if player won
    if didPlayerWin(board: board, piece: "X") {
        print("Congrats Player One, you won!")
        break
    }
    if isBoardFull(board: board) {
        print(tiedMessage)
        break
    }
    
    //tell player two to go
    print(playerTwoGo)
    //take player two's input
    var  playerTwoMove = input()
    //based on that input, perform the player's move on the board
    //if player one move is wrong have them input move again, until corrected, using a while loop
    while processPlayerTurn(input: playerTwoMove, piece: "O") == false {
        print(errorMessage)
        print(playerTwoGo)
        playerTwoMove = input()
    }
    //print board nicely
    printBoard()
    //Check to see if player won
    if didPlayerWin(board: board, piece: "O") {
        print("Congrats Player Two, you won!")
        break
    }
    if isBoardFull(board: board) {
        print(tiedMessage)
        break
    }
}
