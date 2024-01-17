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

            func index(byteCount: Int, offset: Int) throws -> Int {
                guard (0 ..< byteCount).contains(offset) else {
                    throw ExerciseGenerator.ExerciseGeneratorError.internalError(file: #filePath, line: #line, function: #function,
                                                                                 message: "Offset '\(offset)' is not in range of byteCount '\(byteCount)'")
                }
                
                switch self {
                case .little:
                    return byteCount - offset - 1
                case .big:
                    return offset 
                }
            }
        }

        // Helper functions
        static func hexadecimalStringArray(of value: Int64) -> [String] {
            var hexArray: [String] = []

            // Assume a 64-bit integer
            for i in stride(from: 7, through: 0, by: -1) {
                // Shift the desired byte to the rightmost position and mask out other bytes
                let byte = UInt8((value >> (i * 8)) & 0xff)
                
                // Append the hexadecimal representation of the byte to the array
                hexArray.append(String(format: "%02X", byte))
            }

            // Strip leading zeroes
            while hexArray.first == "00" {
                hexArray.removeFirst()
            }
            // Ensure at least a single element
            if hexArray.count == 0 {
                hexArray.append("00")
            }
            
            return hexArray
        }

        static func layoutBytes(bytes: [String], endianness: Endianness) throws -> String {
            var string = ""
            let firstAddress = Int.random(in: 0x1000 ... 0xF0F0)
            for address in firstAddress ..< firstAddress + bytes.count {
                let offset = address - firstAddress
                let index = try endianness.index(byteCount: bytes.count, offset: offset)
                guard (0 ..< bytes.count).contains(index) else {
                    throw ExerciseGenerator.ExerciseGeneratorError.internalError(file: #filePath, line: #line, function: #function, message: "index '\(index)' out of bounds of byte array count '\(bytes.count)'")
                }
                let byte = bytes[index]
                let hexAddress = String(format: "%04X", address)
                string.append("0x\(hexAddress): \(byte) ")
            }

            return string
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
                  <li>For each question, consider the layout of the number in memory.</li>
                  <li>Answer either "big" for big endian or "little" for little endian.</li>
                  <li>Case is significant.</li>
                  </ul>
                  """
                
                instructions += "<ol>"
                for _ in 1 ... repeatCount {
                    let number = Int64.random(in: 0 ..< maxInt)
                    let hex = hexadecimalStringArray(of: number)
                    let hexString = hex.reduce("") {$0 + $1 + " "}

                    let endianness = Bool.random() ? Endianness.little : Endianness.big
                    let memory = try layoutBytes(bytes: hex, endianness: endianness)
                    
                    let question = "Given the number \(hexString) in memory as \(memory)"
                    instructions.append("<li>\(question)</li>")
                    response.append(line: endianness.rawValue, to: .expectedOutput)
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
