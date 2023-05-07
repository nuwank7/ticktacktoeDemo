//
//  ContentView.swift
//  TickTackToeDemo
//
//  Created by Nuwan Kodagoda on 08/05/2023.
//

import SwiftUI

struct ContentView: View {
    let size: CGFloat = 80 // size of each square
    @StateObject var game = TicTacToeGame()
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { row in
                HStack(spacing: 0) {
                    ForEach(0..<3) { column in
                        Button(action: {
                            game.makeMove(row: row, column: column)
                        }) {
                            Text(game.board[row][column])
                                .font(.system(size: size))
                                .frame(width: size, height: size)
                                .background(Color.white)
                                .foregroundColor(Color.black)
                                .border(Color.black, width: 1)
                        }
                    }
                }
            }
            if game.winner != "" {
                        Text("Winner: \(game.winner)")
                            .font(.title)
                            .padding()
                    }
        }
    }
}



class TicTacToeGame: ObservableObject {
    @Published var board = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @Published var currentPlayer = "X"
    @Published var winner = ""
    
    func makeMove(row: Int, column: Int) {
        if board[row][column] == "" && winner == "" {
            board[row][column] = currentPlayer
            currentPlayer = currentPlayer == "X" ? "O" : "X"
            checkForWinner()
        }
    }
    
    func checkForWinner() {
        // Check rows
        for row in 0..<3 {
            if board[row][0] == board[row][1] && board[row][1] == board[row][2] && board[row][0] != "" {
                winner = board[row][0]
            }
        }
        
        // Check columns
        for column in 0..<3 {
            if board[0][column] == board[1][column] && board[1][column] == board[2][column] && board[0][column] != "" {
                winner = board[0][column]
            }
        }
        
        // Check diagonals
        if board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != "" {
            winner = board[0][0]
        }
        
        if board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != "" {
            winner = board[0][2]
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

