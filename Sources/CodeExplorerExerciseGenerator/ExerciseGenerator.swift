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

public class ExerciseGenerator {
    enum ExerciseGeneratorError: Error {
        case invalidExerciseType
        case invalidBoundsSpecified
    }
    

    let exercise: Exercise  
    
    public init(exercise: Exercise) {
        self.exercise = exercise 
    }

    public func generate() throws {
        let response: DynamicResponse
        
        switch exercise {
        // Numeric properties 
        case .isEven(_, _, _):
            response = try NumericProperties.IsEven.generate(exercise: exercise)
        case .isOdd(_, _, _):
            response = try NumericProperties.IsOdd.generate(exercise: exercise)
        case .hasOppositeSigns(_, _, _):
            response = try NumericProperties.HasOppositeSigns.generate(exercise: exercise)

            
        // Primes
        case .isPrime(_, _, _):
            response = try Primes.IsPrime.generate(exercise: exercise)
        case .nextPrime(_, _, _):
            response = try Primes.NextPrime.generate(exercise: exercise)
        case .previousPrime(_, _, _):
            response = try Primes.PreviousPrime.generate(exercise: exercise)

        // Sorts
        case .swap(_, _, _):
            response = try Sorts.Swap.generate(exercise: exercise)
        case .bubbleSort(_, _, _):
            response = try Sorts.BubbleSort.generate(exercise: exercise)

        }

        print(try response.responseString())
    }
}
