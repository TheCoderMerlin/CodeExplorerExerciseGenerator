// CodeExplorerExerciseGenerator
// Copyright (C) 2017-2024 CoderMerlin.Academy
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of           
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
import Foundation

struct Complements {

    // Helper functions

    static func calculateComplement(of number: Int, base: Int, isDiminished: Bool) throws -> Int {
        // There are two main types of complements: Diminished Radix Complement:
        // This is one less than the base. For binary numbers, this is known as
        // the one's complement.  Radix Complement: This is equal to the
        // base. For binary numbers, this is known as the two's complement, and
        // for decimal numbers, it's the ten's complement.
        //
        // We calculate the highest digit of the number in the given base using
        // logarithms.  We then calculate the maximum number that can be represented
        // with that many digits in the given base.  Finally, we subtract the
        // original number from this maximum number to get the complement. If
        // isDiminished is true, we directly return this value; otherwise, we add 1
        // to get the radix complement.
        guard base >= 2 else {
            throw ExerciseGenerator.ExerciseGeneratorError.invalidBase
        }
        guard number >= 0 else {
            throw ExerciseGenerator.ExerciseGeneratorError.invalidNumber(message: "number must be non-negative")
        } 

        let highestDigit = Int(log(Double(number)) / log(Double(base)))
        let maxNumberInBase = Int(pow(Double(base), Double(highestDigit + 1))) - 1

        return isDiminished ? maxNumberInBase - number : maxNumberInBase - number + 1
    }

    struct TestSingleBase {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .testComplementSingleBase(repeatCount, base, isDiminished, complementName, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }
                guard lowerBound >= 0 else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }
                guard base >= 2 else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBase 
                }
                guard repeatCount >= 1 else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidRepeatCountSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()
                let instructions = """
                  <ul>
                  <li>For each question, calculate the \(complementName)'s complement.</li>
                  <li>Provide your answer on the corresponding line number.</li>
                  <li>Follow best practices and customary styles for your answer.</li>
                  <li>Ignore leading zeroes.</li>
                  <li>Do not add blank lines.</li>
                  </ul>
                  <ol>
                  """
                response.append(line: instructions, to: .instructions)

                for _ in 1 ... repeatCount {
                    let number = Int.random(in: lowerBound ... upperBound)
                    let complement = try calculateComplement(of: number, base: base, isDiminished: isDiminished)

                    let numberInBase: String
                    let complementInBase: String

                    switch base {
                    case 2:
                        numberInBase = String(number, radix: base).charactersInSets(of: 4, separatedBy: " ", paddedBy: "0")
                        complementInBase = String(complement, radix: base).charactersInSets(of: 4, separatedBy: " ", paddedBy: "0")
                    case 8:
                        numberInBase = String(number, radix: base).charactersInSets(of: 3, separatedBy: " ", paddedBy: "0")
                        complementInBase = String(complement, radix: base).charactersInSets(of: 3, separatedBy: " ", paddedBy: "0")
                    case 10:
                        numberInBase = String(number, radix: base).charactersInSets(of: 3, separatedBy: ",", paddedBy: " ")
                        complementInBase = String(complement, radix: base).charactersInSets(of: 3, separatedBy: ",", paddedBy: " ")
                    case 16:
                        numberInBase = String(number, radix: base).charactersInSets(of: 2, separatedBy: " ", paddedBy: "0")
                        complementInBase = String(complement, radix: base).charactersInSets(of: 2, separatedBy: " ", paddedBy: "0")
                    default:
                        numberInBase = String(number)
                        complementInBase = String(complement) 
                    }

                    let questionText = "<li>Find the \(complementName)'s complement of \(numberInBase).</li>"
                    response.append(line: questionText, to: .instructions)
                    response.append(line: "\(complementInBase)", to: .expectedOutput)
                }
                response.append(line: "</ol>", to: .instructions)

                return response
                
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
        
    }
                             
}
