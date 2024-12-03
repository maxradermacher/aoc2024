import Foundation

let inputValue = String(data: try! Data(contentsOf: URL(filePath: "day03.txt")), encoding: .utf8)!

func part1() {
	let matcher = /mul\((\d+),(\d+)\)/
	let matches = inputValue.matches(of: matcher)
	var result = 0
	for match in matches {
		result += Int(match.output.1)! * Int(match.output.2)!
	}
	print(result)
}
part1()

func part2() {
	let matcher = /(do|don't|mul)\((?:(\d+),(\d+))?\)/
	let matches = inputValue.matches(of: matcher)
	var result = 0
	var enabled = true
	for match in matches {
		switch match.output.1 {
		case "do": enabled = true
		case "don't": enabled = false
		case "mul" where enabled: result += Int(match.output.2!)! * Int(match.output.3!)!
		default: break
		}
	}
	print(result)
}
part2()
