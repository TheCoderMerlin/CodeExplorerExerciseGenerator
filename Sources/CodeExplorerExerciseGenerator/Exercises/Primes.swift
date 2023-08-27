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


struct Primes {
    // Helper functions
    static func isPrime(maybePrime: Int) -> Bool {
        if maybePrime <= 1 {
            return false
        }
        if maybePrime <= 3 {
            return true
        }
        if maybePrime % 2 == 0 || maybePrime % 3 == 0 {
            return false
        }
        var i = 5
        while i * i <= maybePrime {
            if maybePrime % i == 0 || maybePrime % (i + 2) == 0 {
                return false
            }
            i += 6
        }
        return true
    }

    static func nextPrime(startingNumber: Int) -> Int {
        var maybePrime = startingNumber
        repeat {
            maybePrime += 1
        } while !isPrime(maybePrime: maybePrime)
        return maybePrime    
    }

    static func previousPrime(startingNumber: Int) -> Int? {
        guard startingNumber > 2 else {
        return nil
    }
        var maybePrime = startingNumber
        repeat {
            maybePrime -= 1
        } while !isPrime(maybePrime: maybePrime)
        return maybePrime    
    }
    
    struct IsPrime: ExerciseGeneratable {

        // Generators
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .isPrime(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()     
                let instructions = """
                  <ol>
                  <li>Create a function named <code>isPrime</code> which accepts a single parameter, named <code>maybePrime</code>.</li>
                  <li>The function must return true if and only if <code>maybePrime</code> is prime.</li>
                  <li>Assume that any number less than two is not prime.</li>
                  </ol>
                  """
                response.append(lines: instructions, to: .instructions)
                
                let idealSolution = """
                  func isPrime(maybePrime: Int) -> Bool {     
                      if maybePrime < 2 {                     
                          return false                        
                      }                                       
                                             
                      var evenDivisionCount = 0               
                                             
                      for divisor in 1 ... maybePrime {       
                          if maybePrime % divisor == 0 {      
                              evenDivisionCount += 1          
                          }                                   
                      }                                       
                                             
                      return evenDivisionCount == 2           
                  }                                           
                  """
                response.append(lines: idealSolution, to: .idealSolution)

                for _ in 1 ... repeatCount {
                    let maybePrime = Int.random(in: lowerBound ... upperBound)

                    // Expected output
                    response.append(line: String(maybePrime), to: .expectedOutput)                                                                    
                    response.append(line: String(isPrime(maybePrime: maybePrime)), to: .expectedOutput)

                    // Append 
                    response.append(line: "print(\(maybePrime))", to: .append)
                    response.append(line: "print(isPrime(maybePrime: \(maybePrime)))", to: .append)
                }
                
                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }

    struct NextPrime: ExerciseGeneratable {

        // Generators
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .nextPrime(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()     
                let instructions = """
                  <ol>
                  <li>Create a function named <code>nextPrime</code> which accepts a single parameter, named <code>startingNumber</code>.</li>
                  <li>The function must return the next prime after <code>startingNumber</code>.</li>
                  <li>You may assume that the function <code>isPrime(maybePrime: Int) -> Bool</code> is available.</li>
                  </ol>
                  """
                response.append(lines: instructions, to: .instructions)
                
                let prependCode = """
                  func isPrime(maybePrime: Int) -> Bool {     
                      if maybePrime < 2 {                     
                          return false                        
                      }                                       
                                             
                      var evenDivisionCount = 0               
                                             
                      for divisor in 1 ... maybePrime {       
                          if maybePrime % divisor == 0 {      
                              evenDivisionCount += 1          
                          }                                   
                      }                                       
                                             
                      return evenDivisionCount == 2           
                  }                                           
                  """
                response.append(line: prependCode, to: .prepend)

                let idealSolution = """
                  func nextPrime(startingNumber: Int) -> Int {
                      var maybePrime = startingNumber
                      repeat {
                          maybePrime += 1
                      } while !isPrime(maybePrime: maybePrime)
                      return maybePrime    
                  }
                  """
                response.append(line: idealSolution, to: .idealSolution)
                
                for _ in 1 ... repeatCount {
                    let startingNumber = Int.random(in: lowerBound ... upperBound)

                    // Expected output
                    response.append(line: String(startingNumber), to: .expectedOutput)                                                                    
                    response.append(line: String(nextPrime(startingNumber: startingNumber)), to: .expectedOutput)

                    // Append 
                    response.append(line: "print(\(startingNumber))", to: .append)
                    response.append(line: "print(nextPrime(startingNumber: \(startingNumber)))", to: .append)
                }
                
                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }
    
    struct PreviousPrime: ExerciseGeneratable {

        // Generators
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .previousPrime(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()     
                let instructions = """
                  <ol>
                  <li>Create a function named <code>previousPrime</code> which accepts a single parameter, named <code>startingNumber</code>.</li>
                  <li>The function must return the previous prime before 'startingNumber'.</li>
                  <li>If no such prime number exists, return nil.</li>
                  <li>You may assume that the function <code>isPrime(maybePrime: Int) -> Bool</code> is available.</li>
                  </ol>
                  """
                response.append(lines: instructions, to: .instructions)
                
                let prependCode = """
                  func isPrime(maybePrime: Int) -> Bool {     
                      if maybePrime < 2 {                     
                          return false                        
                      }                                       
                                             
                      var evenDivisionCount = 0               
                                             
                      for divisor in 1 ... maybePrime {       
                          if maybePrime % divisor == 0 {      
                              evenDivisionCount += 1          
                          }                                   
                      }                                       
                                             
                      return evenDivisionCount == 2           
                  }                                           
                  """
                response.append(line: prependCode, to: .prepend)

                let idealSolution = """
                  func previousPrime(startingNumber: Int) -> Int? {
                      guard startingNumber > 2 else {
                          return nil
                      }
                      var maybePrime = startingNumber
                      repeat {
                          maybePrime -= 1
                      } while !isPrime(maybePrime: maybePrime)
                      return maybePrime    
                  }
                  """
                response.append(line: idealSolution, to: .idealSolution)
                
                for _ in 1 ... repeatCount {
                    let startingNumber = Int.random(in: lowerBound ... upperBound)

                    // Expected output
                    response.append(line: String(startingNumber), to: .expectedOutput)                                                                    
                    response.append(line: String(nextPrime(startingNumber: startingNumber)), to: .expectedOutput)

                    // Append 
                    response.append(line: "print(\(startingNumber))", to: .append)
                    response.append(line: "print(nextPrime(startingNumber: \(startingNumber)))", to: .append)
                }
                
                return response
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
    }
    
}

