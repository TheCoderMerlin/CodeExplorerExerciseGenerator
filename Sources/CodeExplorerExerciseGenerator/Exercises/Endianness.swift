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

import Foundation

struct Endianness {

    struct TestEndianness {

        enum Endianness: String {
            case little 
            case big
        }

        // Helper functions
        static func hexadecimalStringArray(of value: Int64) -> [String] {
            var hexArray: [String] = []
            for i in stride(from: 7, through: 0, by: -1) {
                // Shift the desired byte to the rightmost position and mask out other bytes
                let byte = UInt8((value >> (i * 8)) & 0xff)
                
                // Append the hexadecimal representation of the byte to the array
                hexArray.append(String(format: "%02X", byte))
            }
            return hexArray
        }

        static func generate(exercise: Exercise) throws -> DynamicResponse {
            if case let .testEndianness(repeatCount, byteCount) = exercise {
                guard (2 ... 6).contains(byteCount) else {
                    throw ExerciseGenerator.ExerciseGeneratorError.invalidByteCountSpecified
                }
                let bitCount = byteCount * 8
                let maxInt: Int64 = 1 << bitCount 

                let response = CodeExplorerExerciseGenerator.DynamicResponse()
                var instructions = """
                  <ul>
                  <li>For each question, consider the layout of the number in memory. answer either "big" for big endian or "little" for little endian.</li>
                  <li>Case is significant.</li>
                  </ul>
                  """
                
                instructions += "<ol>"
                for _ in 1 ... repeatCount {
                    let number = Int64.random(in: 0 ..< maxInt)
                    let hex = hexadecimalStringArray(of: number)
                    let hexString = hex.map {$0 + " "}

                    let endianness = Bool.random() ? Endianness.little.rawValue : Endianness.big.rawValue 
                    
                    let question = "# Given the number \(hexString) in memory as \(endianness)"
                    instructions.append("<li>\(question)</li>")
                    response.append(line: endianness, to: .expectedOutput)
                }
                instructions += "</ol>"

                response.append(line: instructions, to: .instructions)

                return response 
            } else {
                throw ExerciseGenerator.ExerciseGeneratorError.invalidExerciseType
            }
        }
        
    }
}
