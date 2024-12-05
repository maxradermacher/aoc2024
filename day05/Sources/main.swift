import Foundation

let inputChunks = String(data: try! Data(contentsOf: URL(filePath: "day05.txt")), encoding: .utf8)!
	.trimmingCharacters(in: .whitespacesAndNewlines)
	.split(separator: "\n\n")

let inputRules = inputChunks[0].split(separator: "\n").map {
	let components = $0.split(separator: "|")
	return (Int(components[0])!, Int(components[1])!)
}

let proposedUpdates = inputChunks[1].split(separator: "\n").map {
	return $0.split(separator: ",").map { Int($0)! }
}

struct Rule: Hashable {
	var pageNumber: Int
	var mustComeBefore: Int
}

let pageRules = Set(inputRules.lazy.map { Rule(pageNumber: $0, mustComeBefore: $1) })

func go() {
	var results = [Bool: Int]()
	for proposedUpdate in proposedUpdates {
		let sortedUpdate = proposedUpdate.sorted {
			let result = pageRules.contains(Rule(pageNumber: $0, mustComeBefore: $1))
			assert(result || pageRules.contains(Rule(pageNumber: $1, mustComeBefore: $0)))
			return result
		}
		let medianPage = sortedUpdate[(sortedUpdate.startIndex + sortedUpdate.endIndex) / 2]
		results[sortedUpdate == proposedUpdate, default: 0] += medianPage
	}
	print(results[true, default: 0])
	print(results[false, default: 0])
}
go()
