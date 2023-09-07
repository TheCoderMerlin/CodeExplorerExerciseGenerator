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
    static func swap<T: Comparable>(data: inout [T], firstIndex: Int, secondIndex: Int) {
        precondition((0 ..< data.count).contains(firstIndex), "firstIndex is out of bounds")
        precondition((0 ..< data.count).contains(secondIndex), "secondIndex is out of bounds")
        
        let temp = data[firstIndex]
        data[firstIndex] = data[secondIndex]
        data[secondIndex] = temp
    }

    static func bubbleSort<T: Comparable>(data: inout [T], expectedOutput: inout [String]) {
        guard data.count >= 2 else {
            expectedOutput.append(data.description)
            return
        } 
        
        var didSwap: Bool 
        repeat {
            expectedOutput.append(data.description)
            didSwap = false
            for rightIndex in 1 ..< data.count  {
                let leftIndex = rightIndex - 1
                if data[leftIndex] > data[rightIndex] {
                    swap(data: &data, firstIndex: leftIndex, secondIndex: rightIndex)
                    didSwap = true 
                }
            }
        } while didSwap 
    }

    static func selectionSort<T: Comparable>(data: inout [T], expectedOutput: inout [String]) {
        for targetIndex in 0 ..< data.count-1 {
            expectedOutput.append(data.description)
            var minimumIndex = targetIndex
            for findMinimumIndex in targetIndex+1 ..< data.count {
                if data[findMinimumIndex] < data[minimumIndex] {
                    minimumIndex = findMinimumIndex
                }
            }
            swap(data: &data, firstIndex: minimumIndex, secondIndex:targetIndex)
        }
        expectedOutput.append(data.description)
    }

    static func insertionSort<T:Comparable>(data: inout [T], expectedOutput: inout [String]) {
        for sourceIndex in 1 ..< data.count {
            expectedOutput.append(data.description)
            let sourceElement = data[sourceIndex]
            var moveIndex = sourceIndex - 1

            while ((moveIndex >= 0) && (data[moveIndex] > sourceElement)) {
                data[moveIndex+1] = data[moveIndex]
                moveIndex -= 1
            }
            data[moveIndex+1] = sourceElement
        }
        expectedOutput.append(data.description)
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
                response.append(line: instructions, to: .instructions)

                let idealSolution = """
                  func swap(integers: inout [Int], firstIndex: Int, secondIndex: Int) {
                      let temp = integers[firstIndex]
                      integers[firstIndex] = integers[secondIndex]
                      integers[secondIndex] = temp
                  }
                  """
                response.append(line: idealSolution, to: .idealSolution)

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
                      swap(integers: &\(arrayName), firstIndex: \(firstIndex), secondIndex: \(secondIndex))
                      print(\(arrayName))
                      """
                    response.append(line: append, to: .append)

                    
                    // Expected output
                    response.append(line: "\(swappedIntegers)", to: .expectedOutput)
                }

                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }

    struct BubbleSort {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .bubbleSort(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()
                let instructions = """
                  <ol>
                  <li>Create a function named <code>bubbleSort</code> which accepts a single parameter, <code>integers</code>, an array of integer.</li>
                  <li>The function returns nothing but sorts the array in place using the bubble sort algorithm.</li>
                  <li>The function must print the current contents of the array at the top of each pass.</li>
                  <li>You may assume the function <code>swap(integers: inout [Int], firstIndex: Int, secondIndex: Int)</code> is available.</li>
                  </ol>
                  """
                response.append(line: instructions, to: .instructions)

                let requiredCode = """
                  func swap(integers: inout [Int], firstIndex: Int, secondIndex: Int) {
                      let temp = integers[firstIndex]
                      integers[firstIndex] = integers[secondIndex]
                      integers[secondIndex] = temp
                  }
                  """
                response.append(line: requiredCode, to: .append)
                
                let idealSolution = """
                  func bubbleSort(integers: inout [Int]) {
                      var didSwap: Bool 
                      repeat {
                          print(integers)
                          didSwap = false
                          for rightIndex in 1 ..< integers.count {
                              let leftIndex = rightIndex - 1
                              if integers[leftIndex] > integers[rightIndex] {
                                  swap(integers: &integers, firstIndex: leftIndex, secondIndex: rightIndex)
                                  didSwap = true 
                              }
                           }
                       } while didSwap 
                  }
                  """
                response.append(line: idealSolution, to: .idealSolution)

                for index in 1 ... repeatCount {
                    let integers = try Utility.generateRandomArrayOfInt(elementCount: Int.random(in: 10 ... 20),
                                                                        elementLowerBound: lowerBound, elementUpperBound: upperBound)
                    var sortedIntegers = integers 
                    var expectedOutput = [String]()
                    bubbleSort(data: &sortedIntegers, expectedOutput: &expectedOutput)
                    let arrayName = "integers_\(index)"

                    // Append
                    let append = """
                      var \(arrayName) = \(integers)
                      bubbleSort(integers: &\(arrayName))
                      """
                    response.append(line: append, to: .append)

                    // Expected output
                    response.append(lines: expectedOutput, to: .expectedOutput)
                }


                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }


    struct SelectionSort {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .selectionSort(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()
                let instructions = """
                  <ol>
                  <li>Create a function named <code>selectionSort</code> which accepts a single parameter, <code>integers</code>, an array of integer.</li>
                  <li>The function returns nothing but sorts the array in place using the selection sort algorithm.</li>
                  <li>The function must print the current contents of the array at the top of each pass and once before returning.</li>
                  <li>You may assume the function <code>swap(integers: inout [Int], firstIndex: Int, secondIndex: Int)</code> is available.</li>
                  </ol>
                  """
                response.append(line: instructions, to: .instructions)

                let requiredCode = """
                  func swap(integers: inout [Int], firstIndex: Int, secondIndex: Int) {
                      let temp = integers[firstIndex]
                      integers[firstIndex] = integers[secondIndex]
                      integers[secondIndex] = temp
                  }
                  """
                response.append(line: requiredCode, to: .append)
                
                let idealSolution = """
                  func selectionSort(integers: inout [Int]) {
                      for targetIndex in 0 ..< integers.count-1 {
                          print(integers)
                          var minimumIndex = targetIndex
                          for findMinimumIndex in targetIndex+1 ..< integers.count {
                              if integers[findMinimumIndex] < integers[minimumIndex] {
                                  minimumIndex = findMinimumIndex
                              }
                          }
                          swap(integers: &integers, firstIndex: minimumIndex, secondIndex:targetIndex)
                      }
                      print(integers)
                  }
                  """
                response.append(line: idealSolution, to: .idealSolution)

                for index in 1 ... repeatCount {
                    let integers = try Utility.generateRandomArrayOfInt(elementCount: Int.random(in: 10 ... 20),
                                                                        elementLowerBound: lowerBound, elementUpperBound: upperBound)
                    var sortedIntegers = integers 
                    var expectedOutput = [String]()
                    selectionSort(data: &sortedIntegers, expectedOutput: &expectedOutput)
                    let arrayName = "integers_\(index)"

                    // Append
                    let append = """
                      var \(arrayName) = \(integers)
                      selectionSort(integers: &\(arrayName))
                      """
                    response.append(line: append, to: .append)

                    // Expected output
                    response.append(lines: expectedOutput, to: .expectedOutput)
                }


                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }

    struct InsertionSort {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .insertionSort(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()
                let instructions = """
                  <ol>
                  <li>Create a function named <code>insertionSort</code> which accepts a single parameter, <code>integers</code>, an array of integer.</li>
                  <li>The function returns nothing but sorts the array in place using the insertion sort algorithm.</li>
                  <li>The function must print the current contents of the array at the top of each pass and once before returning.</li>
                  <li>You may assume the function <code>swap(integers: inout [Int], firstIndex: Int, secondIndex: Int)</code> is available.</li>
                  </ol>
                  """
                response.append(line: instructions, to: .instructions)

                let requiredCode = """
                  func swap(integers: inout [Int], firstIndex: Int, secondIndex: Int) {
                      let temp = integers[firstIndex]
                      integers[firstIndex] = integers[secondIndex]
                      integers[secondIndex] = temp
                  }
                  """
                response.append(line: requiredCode, to: .append)
                
                let idealSolution = """
                  func insertionSort(integers: inout [Int]) {
                      for sourceIndex in 1 ..< integers.count {
                          print(integers)
                          let sourceElement = integers[sourceIndex]
                          var moveIndex = sourceIndex - 1

                          while ((moveIndex >= 0) && (integers[moveIndex] > sourceElement)) {
                              integers[moveIndex+1] = integers[moveIndex]
                              moveIndex -= 1
                          }
                          integers[moveIndex+1] = sourceElement
                      }
                      print(integers)
                  }
                  """
                response.append(line: idealSolution, to: .idealSolution)

                for index in 1 ... repeatCount {
                    let integers = try Utility.generateRandomArrayOfInt(elementCount: Int.random(in: 10 ... 20),
                                                                        elementLowerBound: lowerBound, elementUpperBound: upperBound)
                    var sortedIntegers = integers 
                    var expectedOutput = [String]()
                    insertionSort(data: &sortedIntegers, expectedOutput: &expectedOutput)
                    let arrayName = "integers_\(index)"

                    // Append
                    let append = """
                      var \(arrayName) = \(integers)
                      insertionSort(integers: &\(arrayName))
                      """
                    response.append(line: append, to: .append)

                    // Expected output
                    response.append(lines: expectedOutput, to: .expectedOutput)
                }


                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }

}

