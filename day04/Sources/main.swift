import Foundation

let cols = String(data: try! Data(contentsOf: URL(filePath: "day04.txt")), encoding: .utf8)!
	.trimmingCharacters(in: .whitespacesAndNewlines)
	.split(separator: "\n")
	.map { $0.map { $0 } }

extension Array<[Character]> {
	func get(x: Int, y: Int) -> Character? {
		if self.indices.contains(y) {
			if self[y].indices.contains(x) {
				return self[y][x]
			}
		}
		return nil
	}
}

func part1() {
	struct Direction {
		var dx: Int
		var dy: Int
	}

	let directions = [
		Direction(dx: +1, dy: +0),
		Direction(dx: +1, dy: +1),
		Direction(dx: +0, dy: +1),
		Direction(dx: -1, dy: +1),
		Direction(dx: -1, dy: +0),
		Direction(dx: -1, dy: -1),
		Direction(dx: +0, dy: -1),
		Direction(dx: +1, dy: -1),
	]

	var result = 0
	for y in cols.indices {
		for x in cols[y].indices {
		direction_loop:
			for direction in directions {
				for (offset, target) in "XMAS".enumerated() {
					guard cols.get(x: x + direction.dx * offset, y: y + direction.dy * offset) == target else {
						continue direction_loop
					}
				}
				result += 1
			}
		}
	}
	print(result)
}
part1()

func part2() {
	var result = 0
	for y in cols.indices {
		for x in cols[y].indices {
			guard cols.get(x: x, y: y) == "A" else {
				continue
			}
			let axes = [
				[cols.get(x: x - 1, y: y - 1), cols.get(x: x + 1, y: y + 1)],
				[cols.get(x: x - 1, y: y + 1), cols.get(x: x + 1, y: y - 1)],
			]
			if axes.allSatisfy({ $0.compactMap({ $0 }).sorted() == ["M", "S"] }) {
				result += 1
			}
		}
	}
	print(result)
}
part2()
