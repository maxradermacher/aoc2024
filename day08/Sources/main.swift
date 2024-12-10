import Foundation

let inputLines = String(data: try Data(contentsOf: URL(filePath: "day08.txt")), encoding: .utf8)!
	.trimmingCharacters(in: .whitespacesAndNewlines)
	.split(separator: "\n")

struct Position: Hashable {
	var x: Int
	var y: Int

	static func + (lhs: Self, rhs: Self) -> Self {
		return Self(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	}

	static func - (lhs: Self, rhs: Self) -> Self {
		return Self(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
	}

	func isWithin(width: Int, height: Int) -> Bool {
		return self.x >= 0 && self.y >= 0 && self.x < width && self.y < height
	}
}

let antennaPositions = {
	var results = [Character: [Position]]()
	for (y, inputLine) in inputLines.enumerated() {
		for (x, inputCharacter) in inputLine.enumerated() {
			if inputCharacter != "." {
				results[inputCharacter, default: []].append(Position(x: x, y: y))
			}
		}
	}
	return results
}()

let gridWidth = inputLines[0].count
let gridHeight = inputLines.count

func part1() {
	var antinodePositions = Set<Position>()
	for (_, positions) in antennaPositions {
		for (index, p1) in positions.enumerated() {
			for p2 in positions[(index + 1)...] {
				antinodePositions.insert(p1 - (p2 - p1))
				antinodePositions.insert(p2 + (p2 - p1))
			}
		}
	}
	print(antinodePositions.lazy.filter { $0.isWithin(width: gridWidth, height: gridHeight) }.count)
}
part1()


func part2() {
	var antinodePositions = Set<Position>()
	for (_, positions) in antennaPositions {
		for (index, p1) in positions.enumerated() {
			for p2 in positions[(index + 1)...] {
				var (p1, p2) = (p1, p2)
				let delta = p2 - p1
				while p1.isWithin(width: gridWidth, height: gridHeight) {
					antinodePositions.insert(p1)
					p1 = p1 - delta
				}
				while p2.isWithin(width: gridWidth, height: gridHeight) {
					antinodePositions.insert(p2)
					p2 = p2 + delta
				}
			}
		}
	}
	print(antinodePositions.count)
}
part2()
