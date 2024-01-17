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
        case invalidRepeatCountSpecified
        case invalidByteCountSpecified

        case internalError(file: String, line: Int, function: String, message: String)
    }
    

    let exercise: Exercise  
    
    public init(exercise: Exercise) {
        self.exercise = exercise 
    }

    public func generate() throws {
        let response: DynamicResponse
         
        switch exercise {
        // Alternate bases
        case .binaryToDecimal(_, _, _):
            response = try AlternateBases.BinaryToDecimal.generate(exercise: exercise)
        case .octalToDecimal(_, _, _):
            response = try AlternateBases.OctalToDecimal.generate(exercise: exercise)
        case .hexadecimalToDecimal(_, _, _):
            response = try AlternateBases.HexadecimalToDecimal.generate(exercise: exercise)

        // Numeric properties 
        case .isEven(_, _, _):
            response = try NumericProperties.IsEven.generate(exercise: exercise)
        case .isOdd(_, _, _):
            response = try NumericProperties.IsOdd.generate(exercise: exercise)
        case .hasOppositeSigns(_, _, _):
            response = try NumericProperties.HasOppositeSigns.generate(exercise: exercise)

        // Endianess
        case .testEndianness(_, _):
            response = try Endianness.TestEndianness.generate(exercise: exercise)

            
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
        case .selectionSort(_, _, _):
            response = try Sorts.SelectionSort.generate(exercise: exercise)
        case .insertionSort(_, _, _):
            response = try Sorts.InsertionSort.generate(exercise: exercise)
        case .merge(_, _, _):
            response = try Sorts.Merge.generate(exercise: exercise)
        case .mergeSort(_, _, _):
            response = try Sorts.MergeSort.generate(exercise: exercise)
        }

        print(try response.responseString())
    }
}
