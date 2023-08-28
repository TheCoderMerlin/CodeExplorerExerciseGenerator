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

struct Utility {

    static func generateRandomArrayOfInt(elementCount: Int, elementLowerBound: Int, elementUpperBound: Int) throws -> [Int] {
        guard elementCount >= 0 else {
            throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
        }
        guard elementLowerBound < elementUpperBound else {
            throw ExerciseGenerator.ExerciseGeneratorError.invalidBoundsSpecified
        }

        var integers = [Int]()
        for index in 0 ..< elementCount {
            integers.append(Int.random(in: elementLowerBound ... elementUpperBound))
        }
        return integers
    }
}
