// CodeExplorerExerciseGenerator
// Copyright (C) 2017-2024 CoderMerlin.Academy
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

import XCTest
@testable import CodeExplorerExerciseGenerator

class EndiannessTest: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEndiannes() {
        let exercise = Exercise.testEndianness(repeatCount: 10000, byteCount: 2)
        XCTAssertNoThrow(try Endianness.TestEndianness.generate(exercise: exercise))
    }
}
