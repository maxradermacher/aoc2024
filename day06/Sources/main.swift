import Foundation

let inputGrid = {
	var encodedGrid = try! Data(contentsOf: URL(filePath: "day06.txt"))
	_ = encodedGrid.removeLast()
	return encodedGrid.split(separator: "\n".byte).map { [UInt8]($0) }
}()

struct Position: Hashable {
	var x: Int
	var y: Int

	static func + (lhs: Position, rhs: Direction) -> Position {
		return Position(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
	}

	func isWithin(width: Int, height: Int) -> Bool {
		return self.x >= 0 && self.y >= 0 && self.x < width && self.y < height
	}
}

struct Direction: Hashable {
	var dx: Int
	var dy: Int
}

struct State: Hashable {
	var position: Position
	var direction: Direction
}

extension String {
	var byte: UInt8 {
		assert(self.utf8.count == 1)
		return self.utf8.first!
	}
}

let initialPosition = { () -> Position in
	for (y, gridSquares) in inputGrid.enumerated() {
		for (x, gridSquare) in gridSquares.enumerated() {
			if gridSquare == "^".byte {
				return Position(x: x, y: y)
			}
		}
	}
	fatalError()
}()

let initialDirection = Direction(dx: 0, dy: -1)

func part1() {
	var grid = inputGrid
	let foundExit = findExit(grid: &grid, startingAt: initialPosition, facing: initialDirection)
	assert(foundExit)
	let result = grid.flatMap { $0 }.reduce(into: 0) { partialResult, gridSquare in
		if gridSquare == "^".byte || gridSquare == "X".byte {
			partialResult += 1
		}
	}
	print(result)
}
part1()

func findExit(
	grid: inout [[UInt8]],
	startingAt initialPosition: Position,
	facing initialDirection: Direction
) -> Bool {
	var position = initialPosition
	var direction = initialDirection
	var encountered = Set<State>()
	while true {
		let state = State(position: position, direction: direction)
		guard encountered.insert(state).inserted else {
			// We've been here! We're looping!
			return false
		}
		let movePosition = position + direction
		guard movePosition.isWithin(width: grid[0].count, height: grid.count) else {
			// We found an exit!
			return true
		}
		if grid[movePosition.y][movePosition.x] == "#".byte {
			direction = Direction(dx: -direction.dy, dy: direction.dx)
			continue
		}
		position = movePosition
		grid[position.y][position.x] = "X".byte
	}
}

func part2() {
	var grid = inputGrid
	var position = initialPosition
	var direction = initialDirection
	var result = 0
	while true {
		let destPosition = position + direction
		guard destPosition.isWithin(width: grid[0].count, height: grid.count) else {
			break
		}
		let destSquare = grid[destPosition.y][destPosition.x]
		if destSquare == "#".byte {
			direction = Direction(dx: -direction.dy, dy: direction.dx)
			continue
		}
		if destSquare == ".".byte {
			var modifiedGrid = grid
			modifiedGrid[destPosition.y][destPosition.x] = "#".byte
			if !findExit(grid: &modifiedGrid, startingAt: position, facing: direction) {
				result += 1
			}
		}
		position = destPosition
		grid[position.y][position.x] = "X".byte
	}
	print(result)
}
part2()
