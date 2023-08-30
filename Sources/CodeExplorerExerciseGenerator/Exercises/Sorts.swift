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


struct Sorts {
    // Helper functions
    static func swap(integers: inout [Int], firstIndex: Int, secondIndex: Int) {
        precondition((0..<integers.count).contains(firstIndex), "firstIndex is out of bounds")
        precondition((0..<integers.count).contains(secondIndex), "secondIndex is out of bounds")
        
        let temp = integers[firstIndex]
        integers[firstIndex] = integers[secondIndex]
        integers[secondIndex] = temp
    }

    static func bubbleSort(integers: inout [Int], expectedOutput: inout [String]) {
        precondition(integers.count > 1, "integers is too small to sort")
        
        var didSwap: Bool 
        repeat {
            expectedOutput.append(integers.description)
            didSwap = false
            for rightIndex in 1 ..< integers.count - 1 {
                let leftIndex = rightIndex - 1
                if integers[leftIndex] < integers[rightIndex] {
                    swap(integers: &integers, firstIndex: leftIndex, secondIndex: rightIndex)
                    didSwap = true 
                }
            }
        } while didSwap 
    }

    struct Swap: ExerciseGeneratable {

        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .swap(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
            }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()
                let instructions = """
                  <ol>
                  <li>Create a function named <code>swap</code> which accepts three parameters.</li>
                  <li>The first parameter is named <code>integers</code> and is an array of integers.</li>
                  <li>The second and third parameters are named <code>firstIndex</code> and <code>secondIndex</code> of type integer.</li>
                  <li>The function returns nothing but swaps the values at the specified indices in place.</li>
                  </ol>
                  """
                response.append(lines: instructions, to: .instructions)

                let idealSolution = """
                  func swap(integers: inout [Int], firstIndex: Int, secondIndex: Int) {
                      let temp = integers[firstIndex]
                      integers[firstIndex] = integer[secondIndex]
                      integers[secondIndex] = temp
                  }
                  """
                response.append(lines: idealSolution, to: .idealSolution)

                for index in 1 ... repeatCount {
                    let integers = try Utility.generateRandomArrayOfInt(elementCount: Int.random(in: 2 ... 20),
                                                                        elementLowerBound: lowerBound, elementUpperBound: upperBound)
                    let firstIndex = Int.random(in: 0 ..< integers.count)
                    let secondIndex = Int.random(in: 0 ..< integers.count)
                    var swappedIntegers = integers
                    swappedIntegers.swapAt(firstIndex, secondIndex)
                    let arrayName = "integers_\(index)"

                    // Append
                    let append = """
                      var \(arrayName) = \(integers)
                      swap(integers: &\(arrayName))
                      print(\(arrayName))
                      """
                    response.append(lines: append, to: .append)

                    
                    // Expected output
                    response.append(line: "\(swappedIntegers)", to: .expectedOutput)

                    return response 
                }

                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }

    struct BubbleSort {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            let response = CodeExplorerExerciseGenerator.DynamicResponse()
            let idealSolution = """
              func bubbleSort(integers: inout [Int]) {
                  var didSwap: Bool 
                  repeat {
                      didSwap = false
                      for rightIndex in 1 ..< integers.count - 1 {
                          let leftIndex = rightIndex - 1
                          if integers[leftIndex] < integers[rightIndex] {
                              swap(integers: &integers, firstIndex: leftIndex, secondIndex: rightIndex)
                              didSwap = true 
                          }
                      }
                  } while didSwap 
              }
              """
            return response
        }
        
    }
    
}

