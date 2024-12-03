import Foundation

let inputValues = String(data: try! Data(contentsOf: URL(filePath: "day02.txt")), encoding: .utf8)!
	.trimmingCharacters(in: .whitespaces)
	.split(separator: "\n")
	.map {
		return $0.split(separator: " ").map { Int($0)! }
	}

func safe(_ levels: some Sequence<Int>) -> Bool {
	return zip(levels, levels.dropFirst()).allSatisfy { (1...3).contains($1 - $0) }
}

func part1() {
	print(inputValues.lazy.filter { safe($0) || safe($0.lazy.map(-)) }.count)
}
part1()

func nearlySafe(_ levels: [Int]) -> Bool {
	return levels.indices.contains(where: {
		return safe(levels.removingSubranges(RangeSet($0..<($0+1))))
	})
}

func part2() {
	print(inputValues.lazy.filter { nearlySafe($0) || nearlySafe($0.lazy.map(-)) }.count)
}
part2()
