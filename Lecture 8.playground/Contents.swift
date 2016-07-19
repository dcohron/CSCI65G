// Lecture 8 
// July 18, 2016



import UIKit

var rows = 10
var cols = 10

typealias Position = (row:Int, col:Int)

//struct Position {
//    var row: Int = 0
//    var col: Int = 0
//    init(row: Int, col: Int) {self.row = row; self.col = col}
//}

let offsets:[Position] = [
    (-1, -1), (-1,0), (-1, 1),
    (0, -1),           (0, 1),
    (1, -1), (1, 0),  (1, 1)
]


//let offsets:[Position] = [
//    Position(row: -1, col: -1), Position(row: -1, col: 0), Position(row: -1, col: 1),
//    Position(row: 0, col: -1),                             Position(row: 0, col: 1),
//    Position(row: 1, col: -1),  Position(row: 1, col: 0),  Position(row: 1, col: 1)
//]

func neighbors (pos: Position) -> [Position] {
    return offsets.map {((pos.row + rows + $0.row)%rows, (pos.col + cols + $0.col)%cols)}
}

// neighbors((9,9))

typealias CellState = Bool
typealias Cell = (position: Position, alive: CellState)

var toyGrid = [Cell](count: rows * cols, repeatedValue: ((0,0), false))

for var i in 0..<rows {
    for var j in 0..<cols {
        toyGrid[i*cols + j] = ((i,j), arc4random_uniform(3) == 1)
    }
}


let numCells = rows*cols
for var i in 0..<numCells {
    toyGrid[i] = (( i/cols, i%cols), arc4random_uniform(3) == 1)
}

var grid = (0..<numCells).map {
    (($0/cols, $0%cols), arc4random_uniform(3) == 1) as Cell
}

grid

func countLiving(grid:[Cell]) -> Int {
    return grid.reduce(0) {return $1.alive ? $0 + 1 : $0}
}

countLiving(grid)

func countLivingNeighbors(grid: [Cell], cell: Cell) -> Int {
    return neighbors((cell.position.row, cell.position.col))
        .reduce(0) { grid[$1.row*cols + $1.col].alive ? $0 + 1 : $0 }
}
func step(grid:[Cell]) -> [Cell] {
    return grid.map {
        switch countLivingNeighbors(grid, cell: $0) {
        case 3, 2 where $0.alive: return ($0.position, true)
        default: return ($0.position, false)
        }
    }
}

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)


