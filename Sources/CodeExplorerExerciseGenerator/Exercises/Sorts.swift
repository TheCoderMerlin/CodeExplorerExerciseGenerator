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

    static func merge<T:Comparable>(data:inout [T], leftLowerBoundIndex:Int, middleBoundIndex:Int, rightUpperBoundIndex:Int, expectedOutput: inout [String])  {
        // Create temporary arrays
        let leftUpperBoundIndex = middleBoundIndex
        let rightLowerBoundIndex = leftUpperBoundIndex + 1


        let leftArray = Array(data[leftLowerBoundIndex ... leftUpperBoundIndex])
        let rightArray = Array(data[rightLowerBoundIndex ... rightUpperBoundIndex])

        // Merge arrays back into source from leftLowerBoundIndex to rightUpperBoundIndex
        var leftIndex = 0
        var rightIndex = 0
        var mergedIndex = leftLowerBoundIndex

        while (leftIndex < leftArray.count && rightIndex < rightArray.count) {
            if leftArray[leftIndex] <= rightArray[rightIndex] {
                data[mergedIndex] = leftArray[leftIndex]
                leftIndex += 1
            } else {
                data[mergedIndex] = rightArray[rightIndex]
                rightIndex += 1
            }
            mergedIndex += 1
            expectedOutput.append(data.description)
        }

        // Copy remaining elements from the left (if any)
        while (leftIndex < leftArray.count) {
            data[mergedIndex] = leftArray[leftIndex]
            leftIndex += 1
            mergedIndex += 1
            expectedOutput.append(data.description)
        }

        // Copy remaining elements from the right (if any)
        while (rightIndex < rightArray.count) {
            data[mergedIndex] = rightArray[rightIndex]
            rightIndex += 1
            mergedIndex += 1
            expectedOutput.append(data.description)
        }
    }

    public static func mergeSort<T:Comparable>(data:inout [T], lowerBoundIndex:Int, upperBoundIndex:Int, expectedOutput: inout [String])  {
        if (lowerBoundIndex < upperBoundIndex) {
            let middleBoundIndex = (lowerBoundIndex + upperBoundIndex) / 2

            // Sort the left and right halves individually
            mergeSort(data:&data, lowerBoundIndex:lowerBoundIndex, upperBoundIndex:middleBoundIndex, expectedOutput: &expectedOutput)
            mergeSort(data:&data, lowerBoundIndex:middleBoundIndex+1, upperBoundIndex:upperBoundIndex, expectedOutput: &expectedOutput)

            // Then merge the two halves back together
            var ignoredOutput = [String]()
            merge(data:&data, leftLowerBoundIndex:lowerBoundIndex, middleBoundIndex:middleBoundIndex, rightUpperBoundIndex:upperBoundIndex, expectedOutput: &ignoredOutput)
            expectedOutput.append(data.description)
        }
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

    struct Merge {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .merge(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()
                let instructions = """
                  <ol>
                  <li>Create a function named <code>merge</code> which accepts four parameters:</li>
                  <ol type="A">
                  <li><code>integers</code>, an array of integers.</li>
                  <li><code>leftLowerBoundIndex</code>, an integer.</li>
                  <li><code>middleBoundIndex</code>, an integer.</li>
                  <li><code>rightUpperBoundIndex</code>, an integer.</li>
                  </ol>
                  <li>The function returns nothing but sorts the array in place by progressively obtaining the smaller integer
                  from either the left array (from leftLowerBoundIndex through the middleBoundIndex) or the right array
                  (from middleBoundIndex + 1 through the rightUpperBoundIndex) and placing it into the original array
                  beginning at the left-most index and progressing rightward.</li>
                  <li>The function must print the current contents of <code>integers</code> immediately after each element
                  is placed.
                  </li>
                  </ol>
                  """
                response.append(line: instructions, to: .instructions)

                let idealSolution = """
                  func merge(integers: inout [Int], leftLowerBoundIndex:Int, middleBoundIndex:Int, rightUpperBoundIndex:Int)  {
                      // Create temporary arrays
                      let leftUpperBoundIndex = middleBoundIndex
                      let rightLowerBoundIndex = leftUpperBoundIndex + 1


                      let leftArray = Array(integers[leftLowerBoundIndex ... leftUpperBoundIndex])
                      let rightArray = Array(integers[rightLowerBoundIndex ... rightUpperBoundIndex])

                      // Merge arrays back into source from leftLowerBoundIndex to rightUpperBoundIndex
                      var leftIndex = 0
                      var rightIndex = 0
                      var mergedIndex = leftLowerBoundIndex

                      while (leftIndex < leftArray.count && rightIndex < rightArray.count) {
                          if leftArray[leftIndex] <= rightArray[rightIndex] {
                              integers[mergedIndex] = leftArray[leftIndex]
                              leftIndex += 1
                          } else {
                              integers[mergedIndex] = rightArray[rightIndex]
                              rightIndex += 1
                          }
                          mergedIndex += 1
                          print(integers)
                      }

                      // Copy remaining elements from the left (if any)
                      while (leftIndex < leftArray.count) {
                          integers[mergedIndex] = leftArray[leftIndex]
                          leftIndex += 1
                          mergedIndex += 1
                          print(integers)
                      }

                      // Copy remaining elements from the right (if any)
                      while (rightIndex < rightArray.count) {
                          integers[mergedIndex] = rightArray[rightIndex]
                          rightIndex += 1
                          mergedIndex += 1
                          print(integers)
                      }
                  }

                  """
                response.append(line: idealSolution, to: .idealSolution)

                for index in 1 ... repeatCount {
                    let leftElementCount = Int.random(in: 5 ... 10)
                    let rightElementCount = leftElementCount + (Bool.random() ? 1 : 0)
                    let leftArray = try Utility.generateRandomArrayOfInt(elementCount: leftElementCount, elementLowerBound: lowerBound, elementUpperBound: upperBound).sorted()
                    let rightArray = try Utility.generateRandomArrayOfInt(elementCount: rightElementCount, elementLowerBound: lowerBound, elementUpperBound: upperBound).sorted()

                    var integers = leftArray + rightArray
                    let middleBoundIndex = integers.count / 2

                    var expectedOutput = [String]()
                    merge(data: &integers, leftLowerBoundIndex: 0, middleBoundIndex: middleBoundIndex, rightUpperBoundIndex: integers.count - 1, expectedOutput: &expectedOutput)
                    let arrayName = "integers_\(index)"

                    // Append
                    let append = """
                      var \(arrayName) = \(integers)
                      merge(integers: &\(arrayName))
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

    struct MergeSort {
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .mergeSort(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()
                let instructions = """
                  <ol>
                  <li>Create a function named <code>mergeSort</code> which accepts a single parameter, <code>integers</code>, an array of integer.</li>
                  <li>The function returns nothing but sorts the array in place using the merge sort algorithm.</li>
                  <li>The function must print the current contents of each merged array immediately after combining the two halves.</li>
                  </ol>
                  """
                response.append(line: instructions, to: .instructions)

                let idealSolution = """
                  func mergeSort(integers: inout [Int]) {
                      mergeSort(integers: &integers, lowerBoundIndex: 0, upperBoundIndex: integers.count - 1)
                  }

                  func mergeSort(integers: inout [Int], lowerBoundIndex:Int, upperBoundIndex:Int) {
                      if (lowerBoundIndex < upperBoundIndex) {
                          let middleBoundIndex = (lowerBoundIndex + upperBoundIndex) / 2

                          // Sort the left and right halves individually
                          mergeSort(integers: &integers, lowerBoundIndex:lowerBoundIndex, upperBoundIndex:middleBoundIndex)
                          mergeSort(integers: &integers, lowerBoundIndex:middleBoundIndex+1, upperBoundIndex:upperBoundIndex)

                          // Then merge the two halves back together
                          merge(integers: &integers, leftLowerBoundIndex:lowerBoundIndex, middleBoundIndex:middleBoundIndex, rightUpperBoundIndex:upperBoundIndex)
                          print(integers)
                      }
                  }

                  func merge(integers: inout [Int], leftLowerBoundIndex:Int, middleBoundIndex:Int, rightUpperBoundIndex:Int)  {
                      // Create temporary arrays
                      let leftUpperBoundIndex = middleBoundIndex
                      let rightLowerBoundIndex = leftUpperBoundIndex + 1


                      let leftArray = Array(integers[leftLowerBoundIndex ... leftUpperBoundIndex])
                      let rightArray = Array(integers[rightLowerBoundIndex ... rightUpperBoundIndex])

                      // Merge arrays back into source from leftLowerBoundIndex to rightUpperBoundIndex
                      var leftIndex = 0
                      var rightIndex = 0
                      var mergedIndex = leftLowerBoundIndex

                      while (leftIndex < leftArray.count && rightIndex < rightArray.count) {
                          if leftArray[leftIndex] <= rightArray[rightIndex] {
                              integers[mergedIndex] = leftArray[leftIndex]
                              leftIndex += 1
                          } else {
                              integers[mergedIndex] = rightArray[rightIndex]
                              rightIndex += 1
                          }
                          mergedIndex += 1
                      }

                      // Copy remaining elements from the left (if any)
                      while (leftIndex < leftArray.count) {
                          integers[mergedIndex] = leftArray[leftIndex]
                          leftIndex += 1
                          mergedIndex += 1
                      }

                      // Copy remaining elements from the right (if any)
                      while (rightIndex < rightArray.count) {
                          integers[mergedIndex] = rightArray[rightIndex]
                          rightIndex += 1
                          mergedIndex += 1
                      }
                  }

                  """
                response.append(line: idealSolution, to: .idealSolution)

                for index in 1 ... repeatCount {
                    let integers = try Utility.generateRandomArrayOfInt(elementCount: Int.random(in: 10 ... 20),
                                                                        elementLowerBound: lowerBound, elementUpperBound: upperBound)
                    var sortedIntegers = integers 
                    var expectedOutput = [String]()
                    mergeSort(data: &sortedIntegers, lowerBoundIndex: 0, upperBoundIndex: sortedIntegers.count - 1, expectedOutput: &expectedOutput)
                    let arrayName = "integers_\(index)"

                    // Append
                    let append = """
                      var \(arrayName) = \(integers)
                      mergeSort(integers: &\(arrayName))
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

