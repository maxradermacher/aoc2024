import Foundation

let inputValues = String(data: try! Data(contentsOf: URL(filePath: "day01.txt")), encoding: .utf8)!
	.trimmingCharacters(in: .whitespaces).split(separator: "\n").map {
		let components = $0.split(separator: " ", omittingEmptySubsequences: true)
		return (Int(components[0])!, Int(components[1])!)
	}

let lhs = inputValues.map(\.0).sorted()
let rhs = inputValues.map(\.1).sorted()

func part1() {
	let differences = zip(lhs, rhs).map { abs($1 - $0) }
	print(differences.reduce(0, +))
}
part1()

func part2() {
	var frequencies = [Int: Int]()
	rhs.forEach { frequencies[$0, default: 0] += 1 }
	let multiples = lhs.map { $0 * frequencies[$0, default: 0] }
	print(multiples.reduce(0, +))
}
part2()
