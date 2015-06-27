//
// Created by Andrew Torski on 23/06/15.
// Copyright (c) 2015 Andrew Torski. All rights reserved.
//

import Foundation

public class Life {

    //  Class members.

    var board : [[Bool]]
    var numberOfRows : Int
    var numberOfColumns : Int

    //  End of Class Members.


    // Constructors.

    init(numberOfRows: Int, numberOfColumns: Int){
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns

        self.board = Array(count: numberOfRows, repeatedValue: Array(count: numberOfColumns, repeatedValue: false))
    }

    // End of Constructors.
    /**
        Prints out the board to the standard output.
    */

    //  Public functions.

    /**
        Evaluates once the board and returns the board.

        :return: Two dimensional array of bool cells.
    */
    func evolve() -> [[Bool]]{

        /*
            For each cell on each evolution(or turn, or state, or whatever you might want to call it
            we consider three(3) states:
            1.  STASIS - if a cell has exactly TWO(2) neighbours, nothing happens to the cell.
                If it was alive, it remains alive; if it was dead, it remains dead.

            2.  GROWTH - if a cell has exactly THREE(3) neighbours, the cell will be alive in the next generation.

            3.  DEATH - if a cell has ZERO(0) or ONE(1) or FOUR(4) through EIGHT(8)(i.e. 4-8) neighbours, the cell will
                be dead in the next genration.
        */

        var newBoard : [[Bool]] = Array(count: numberOfRows, repeatedValue: Array(count: numberOfColumns, repeatedValue: false))

        for var rowNumber = 0; rowNumber < numberOfRows; rowNumber++ {
            for var columnNumber = 0; columnNumber < numberOfColumns; columnNumber++ {
                let numberOfAdjacentCells = self.getNumberOfAdjacentCellsTo(row: rowNumber, column: columnNumber)
                if numberOfAdjacentCells == 2 {
                    newBoard[rowNumber][columnNumber] = board[rowNumber][columnNumber]
                }
                if numberOfAdjacentCells == 3 {
                    newBoard[rowNumber][columnNumber] = true
                }
                if numberOfAdjacentCells < 2 || numberOfAdjacentCells > 3 {
                    newBoard[rowNumber][columnNumber] = false
                }
            }
        }

        board = newBoard

        return board
    }

    func evolveAndPrint(){
        evolveAndPrint(andSleepFor:nil)
    }

    func evolveAndPrint(#andSleepFor:UInt32?){
        self.evolve()
        self.printBoard()
        if(andSleepFor != nil){
            let sleepLength : UInt32 = andSleepFor! as UInt32
            sleep(sleepLength)
        }
    }

    func printBoard(){
        print("  ")
        for i in 0..<numberOfColumns{
            print(i + 1)
            print(" ")

        }
        var i = 1
        println()
        for row in board{
            print(i)
            i++
            for value in row{
                var char = value ? "x" : " "
                print(" " + char)
            }
            println()
        }
    }

    /**
        Marks the cell in board as populated.

        :param: row Row number of the cell.
        :param: column Column number of the cell.

    */
    func markBoard(row: Int, column: Int) {
        if (row > self.numberOfRows || row < 0) || (column > self.numberOfColumns || column < 0) {
            return
        }
        board[row][column] = !board[row][column]
    }

    func getNumberOfAdjacentCellsTo(#row: Int, column: Int) -> Int{
        //  go around the cell

        //  -1 ,-1 | -1, 0 | -1, 1
        //   0, -1 |  0, 0 |  0, 1
        //   1, -1 |  1, 0 |  1, 1
        /*
            (0,0) marks the current cell coordinates
            in below two for loops we iterate over the adjacent cells
        */

        var count : Int = 0

        for var k = -1; k < 2; k++ {
            for var l = -1; l < 2; l++ {
                if k != 0 || l != 0 {
                    let calculatedX = xAdd(row, a: k)
                    let calculatedY = yAdd(column, a: l)
                    var boardValue = board[calculatedX][calculatedY]
                    if boardValue {
                        count++
                    }
                }
            }
        }

        return count
    }

    //  End of Public functions.

    // Helper functions

    private func initializeBoard(numberOfRows: Int, numberOfColumns: Int) -> [[Bool]]{
        return Array(count: numberOfRows, repeatedValue: Array(count: numberOfColumns, repeatedValue: false))
    }

    private func xAdd(i: Int, a: Int) -> Int{
        return universalAdd(i, a: a, dimensionSize: numberOfColumns)
    }

    private func yAdd(i: Int, a: Int) -> Int{
        return universalAdd(i, a: a, dimensionSize: numberOfRows)
    }

    private func universalAdd(i: Int, a: Int, dimensionSize: Int) -> Int{
        var result = i + a
        while result < 0{
            result = result + dimensionSize
        }
        while result >= dimensionSize {
            result = result - dimensionSize
        }

        return result;
    }

    // End of Helper functions

}
