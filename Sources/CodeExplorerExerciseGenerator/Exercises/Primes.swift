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
    static func isPrime(_ n: Int) -> Bool {
        if n <= 1 {
            return false
        }
        if n <= 3 {
            return true
        }
        if n % 2 == 0 || n % 3 == 0 {
            return false
        }
        var i = 5
        while i * i <= n {
            if n % i == 0 || n % (i + 2) == 0 {
                return false
            }
            i += 6
        }
        return true
    }

    struct SinglePrime: ExerciseGeneratable {

        // Generators
        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .isPrime(repeatCount, lowerBound, upperBound) = exercise {
                guard lowerBound < upperBound else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
                }

                let response = CodeExplorerExerciseGenerator.DynamicResponse()     
                let instructions = """
                  Create a function named 'isPrime' which accepts a single parameter,
                  named 'maybePrime'. The function must return true if and only if
                  'maybePrime' is prime.
                  Assume that any number less than two is not prime.
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
                    response.append(line: String(isPrime(maybePrime)), to: .expectedOutput)

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
}

