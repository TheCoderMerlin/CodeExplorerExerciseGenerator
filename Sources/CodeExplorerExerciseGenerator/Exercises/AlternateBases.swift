// CodeExplorerExerciseGenerator
// Copyright (C) 2017-2023 CoderMerlin.Academy
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

struct AlternateBases {

    struct BinaryToDecimal: ExerciseGeneratable {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .binaryToDecimal(repeatCount, lowerBound, upperBound) = exercise {
                guard repeatCount >= 1 else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidRepeatCountSpecified
                }
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()     
                let instructions = """
                  <ul>
                  <li>For each question, convert the number from binary to decimal.</li>
                  <li>Provide your answer on the corresponding line number.</li>
                  <li>Follow best practices and customary styles for your answer.</li>
                  <li>Do not add blank lines.</li>
                  </ul>
                  <ol>
                  """
                response.append(line: instructions, to: .instructions)

                for _ in 1 ... repeatCount {
                    let decimalNumber = Int.random(in: lowerBound ... upperBound)
                    let binaryNumber  = String(decimalNumber, radix:2).charactersInSets(of: 4, separatedBy: " ", paddedBy:"0")
                    let questionText = "<li>Convert \(binaryNumber) to decimal.</li>"
                    response.append(line: questionText, to: .instructions)

                    // Expected output
                    response.append(line: "\(decimalNumber)", to: .expectedOutput)
                }
                response.append(line: "</ol>", to: .instructions)
                    

                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }

    struct OctalToDecimal: ExerciseGeneratable {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .octalToDecimal(repeatCount, lowerBound, upperBound) = exercise {
                guard repeatCount >= 1 else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidRepeatCountSpecified
                }
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()     
                let instructions = """
                  <ul>
                  <li>For each question, convert the number from octal to decimal.</li>
                  <li>Provide your answer on the corresponding line number.</li>
                  <li>Follow best practices and customary styles for your answer.</li>
                  <li>Do not add blank lines.</li>
                  </ul>
                  <ol>
                  """
                response.append(line: instructions, to: .instructions)

                for _ in 1 ... repeatCount {
                    let decimalNumber = Int.random(in: lowerBound ... upperBound)
                    let octalNumber  = String(decimalNumber, radix:8).charactersInSets(of: 3, separatedBy: " ", paddedBy:"0")
                    let questionText = "<li>Convert \(octalNumber) to decimal.</li>"
                    response.append(line: questionText, to: .instructions)

                    // Expected output
                    response.append(line: "\(decimalNumber)", to: .expectedOutput)
                }
                response.append(line: "</ol>", to: .instructions)
                    

                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }

    struct HexadecimalToDecimal: ExerciseGeneratable {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .octalToDecimal(repeatCount, lowerBound, upperBound) = exercise {
                guard repeatCount >= 1 else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidRepeatCountSpecified
                }
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()     
                let instructions = """
                  <ul>
                  <li>For each question, convert the number from hexadecimal to decimal.</li>
                  <li>Provide your answer on the corresponding line number.</li>
                  <li>Follow best practices and customary styles for your answer.</li>
                  <li>Do not add blank lines.</li>
                  </ul>
                  <ol>
                  """
                response.append(line: instructions, to: .instructions)

                for _ in 1 ... repeatCount {
                    let decimalNumber = Int.random(in: lowerBound ... upperBound)
                    let hexadecimalNumber  = String(decimalNumber, radix: 16).charactersInSets(of: 2, separatedBy: " ", paddedBy:"0")
                    let questionText = "<li>Convert \(hexadecimalNumber) to decimal.</li>"
                    response.append(line: questionText, to: .instructions)

                    // Expected output
                    response.append(line: "\(decimalNumber)", to: .expectedOutput)
                }
                response.append(line: "</ol>", to: .instructions)
                    

                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }

}
