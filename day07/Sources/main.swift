import Foundation

let inputEquations = String(data: try Data(contentsOf: URL(filePath: "day07.txt")), encoding: .utf8)!
	.trimmingCharacters(in: .whitespacesAndNewlines)
	.split(separator: "\n")
	.map { equation in
		let equationComponents = equation.split(separator: ": ")
		assert(equationComponents.count == 2)
		let testValue = Int(equationComponents[0])!
		let numbers = equationComponents[1].split(separator: " ").map { Int($0)! }
		return (testValue, numbers)
	}

func canMakeTestValue(
	_ testValue: Int,
	startingAt currentValue: Int,
	remainingNumbers: ArraySlice<Int>,
	canUseConcatenation: Bool
) -> Bool {
	if currentValue > testValue {
		return false
	}
	if let nextNumber = remainingNumbers.first {
		var nextValues = [currentValue + nextNumber, currentValue * nextNumber]
		if canUseConcatenation {
			nextValues.append(Int(String(currentValue) + String(nextNumber))!)
		}
		for nextValue in nextValues {
			let result = canMakeTestValue(
				testValue,
				startingAt: nextValue,
				remainingNumbers: remainingNumbers.dropFirst(),
				canUseConcatenation: canUseConcatenation
			)
			if result {
				return true
			}
		}
		return false
	} else {
		return currentValue == testValue
	}
}

func part1() {
	var totalCalibrationResult = 0
	for (testValue, numbers) in inputEquations {
		if canMakeTestValue(testValue, startingAt: numbers.first!, remainingNumbers: numbers.dropFirst(), canUseConcatenation: false) {
			totalCalibrationResult += testValue
		}
	}
	print(totalCalibrationResult)
}
part1()

func part2() {
	var totalCalibrationResult = 0
	for (testValue, numbers) in inputEquations {
		if canMakeTestValue(testValue, startingAt: numbers.first!, remainingNumbers: numbers.dropFirst(), canUseConcatenation: true) {
			totalCalibrationResult += testValue
		}
	}
	print(totalCalibrationResult)
}
part2()
