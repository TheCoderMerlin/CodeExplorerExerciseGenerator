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

import Foundation

public class DynamicResponse {
    var targetFilesDictionary = [String: String]()

    public init() {
        for targetPathname in TargetPathname.allCases {
            targetFilesDictionary[targetPathname.rawValue] = String()
        }
    }

    public func append(line: String, to targetPathname: TargetPathname) {
        let lineAndNewline = line + "\n"
        targetFilesDictionary[targetPathname.rawValue]!.append(lineAndNewline)
    }

    public func append(lines: [String], to targetPathname: TargetPathname) {
        let linesAndNewline = lines.joined(separator: "\n") + "\n"
        targetFilesDictionary[targetPathname.rawValue]!.append(linesAndNewline)
    }

    private func response() throws -> Response {
        let nonEmptyTargetFilesDictionary = targetFilesDictionary.filter { !$0.value.isEmpty }
        let nonEmptyTargetFiles = nonEmptyTargetFilesDictionary.map { TargetFile(path: $0.key, contents: $0.value) }
        return Response(targetFiles: nonEmptyTargetFiles)
    }

    public func responseString() throws -> String {
        let jsonEncoder = JSONEncoder()
        let string = try String(data: jsonEncoder.encode(response()), encoding: .utf8)!
        return string 
    }
    
}
