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


struct NumericProperties {
    // Helper functions
    static func isEven(maybeEven: Int) -> Bool {
        return maybeEven % 2 == 0
    }

    static func isOdd(maybeOdd: Int) -> Bool {
        return !isEven(maybeEven: maybeOdd)
    }

    static func hasOppositeSigns(firstNumber: Int, secondNumber: Int) -> Bool {
        return (firstNumber ^ secondNumber) < 0
    }

    struct IsEven: ExerciseGeneratable {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .isEven(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()     
                let instructions = """
                  <ol>
                  <li>Create a function named <code>isEven</code> which accepts a single integer parameter named <code>maybeEven</code>.</li>
                  <li>The function must return true if and only if the given number is even.</li>
                  </ol>
                  """
                response.append(line: instructions, to: .instructions)

                let idealSolution = """
                  func isEven(maybeEven: Int) -> Bool {
                      return maybeEven % 2 == 0
                  }
                  """
                response.append(line: idealSolution, to: .idealSolution)

                for _ in 1 ... repeatCount {
                    let maybeEven = Int.random(in: lowerBound ... upperBound)

                    // Expected output
                    response.append(line: "\(maybeEven): \(isEven(maybeEven: maybeEven))", to: .expectedOutput)

                    // Append
                    response.append(line: "print(\(maybeEven), isEven(maybeEven: \(maybeEven)), separator: \": \")", to: .append)
                }

                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }

    struct IsOdd: ExerciseGeneratable {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .isOdd(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()     
                let instructions = """
                  <ol>
                  <li>Create a function named <code>isOdd</code> which accepts a single integer parameter named <code>maybeOdd</code>.</li>
                  <li>The function must return true if and only if the given number is odd.</li>
                  <li>Assume that the function <code>isEven(maybeEven: Int) -> Bool</code> is defined.</li>
                  </ol>
                  """
                response.append(line: instructions, to: .instructions)

                let requiredCode = """
                  func isEven(maybeEven: Int) -> Bool {
                      return maybeEven % 2 == 0
                  }
                  """
                response.append(line: requiredCode, to: .append)
                

                let idealSolution = """
                  func isOdd(maybeOdd: Int) -> Bool {
                      return !isEven(maybeEven: maybeOdd)
                  }
                  """
                response.append(line: idealSolution, to: .idealSolution)

                for _ in 1 ... repeatCount {
                    let maybeOdd = Int.random(in: lowerBound ... upperBound)

                    // Expected output
                    response.append(line: "\(maybeOdd): \(isOdd(maybeOdd: maybeOdd))", to: .expectedOutput)

                    // Append
                    response.append(line: "print(\(maybeOdd), isOdd(maybeOdd: \(maybeOdd)), separator: \": \")", to: .append)
                }

                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }

    struct HasOppositeSigns: ExerciseGeneratable {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .hasOppositeSigns(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()     
                let instructions = """
                  <ol>
                  <li>Create a function named <code>hasOppositeSigns</code> which accepts a two integer parameters named <code>firstNumber</code> and <code>secondNumber</code>.</li>
                  <li>The function must return true if and only if firstNumber has the opposite sign of secondNumber.</li>
                  <li>Assume that the following functions are defined:
                      <ol>
                      <li><code>isEven(maybeEven: Int) -> Bool</code></li>
                      <li><code>isOdd(maybeOdd: Int) -> Bool</code></li>
                      </ol>
                  </li>
                  </ol>
                  """
                response.append(line: instructions, to: .instructions)

                let requiredCode = """
                  func isEven(maybeEven: Int) -> Bool {
                      return maybeEven % 2 == 0
                  }

                  func isOdd(maybeOdd: Int) -> Bool {
                      return !isEven(maybeEven: maybeOdd)
                  }
                  """
                response.append(line: requiredCode, to: .append)
                

                let idealSolution = """
                  func hasDifferentSigns(firstNumber: Int, secondNumber: Int) -> Bool {
                      return ((isEven(maybeEven: firstNumber) && isOdd(maybeOdd: secondNumber))
                              (isOdd(maybeOdd: firstNumber) && isEven(maybeEven: secondNumber)))
                  }
                  """
                response.append(line: idealSolution, to: .idealSolution)

                for _ in 1 ... repeatCount {
                    let firstNumber = Int.random(in: lowerBound ... upperBound)
                    let secondNumber = Int.random(in: lowerBound ... upperBound) 

                    // Expected output
                    response.append(line: "\(firstNumber), \(secondNumber): \(hasOppositeSigns(firstNumber: firstNumber, secondNumber: secondNumber))", to: .expectedOutput)

                    // Append
                    response.append(line: "print(\(firstNumber), \", \", \(secondNumber), \": \", hasOppositeSigns(firstNumber: \(firstNumber), secondNumber: \(secondNumber)), separator: \"\")", to: .append)
                }

                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
        
    }
}
