//
//  main.swift
//  Game-of-Life
//
//  Created by Andrew Torski on 23/06/15.
//  Copyright (c) 2015 Andrew Torski. All rights reserved.
//

import Foundation

var life = Life(numberOfRows: 10, numberOfColumns: 10)
life.evolveAndPrint()
life.markBoard(0, column: 1)
life.markBoard(1, column: 2)
life.markBoard(2, column: 0)
life.markBoard(2, column: 1)
life.markBoard(2, column: 2)

for i in 0..<50 {
    life.evolveAndPrint(andSleepFor: 1)
}
//println("Hello, World!")

