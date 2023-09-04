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

public enum Exercise {
    // Alternate Bases
    case binaryToDecimal(repeatCount: Int, lowerBound: Int, upperBound: Int)
    case octalToDecimal(repeatCount: Int, lowerBound: Int, upperBound: Int)
    case hexadecimalToDecimal(repeatCount: Int, lowerBound: Int, upperBound: Int)
    
    // Numeric Properties
    case isEven(repeatCount: Int, lowerBound: Int, upperBound: Int)
    case isOdd(repeatCount: Int, lowerBound: Int, upperBound: Int)
    case hasOppositeSigns(repeatCount: Int, lowerBound: Int, upperBound: Int)
    
    // Primes
    case isPrime(repeatCount: Int, lowerBound: Int, upperBound: Int)
    case nextPrime(repeatCount: Int, lowerBound: Int, upperBound: Int)
    case previousPrime(repeatCount: Int, lowerBound: Int, upperBound: Int)

    // Sorts
    case swap(repeatCount: Int, lowerBound: Int, upperBound: Int)
    case bubbleSort(repeatCount: Int, lowerBound: Int, upperBound: Int)
    
}
