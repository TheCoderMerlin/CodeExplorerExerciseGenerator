import Foundation

public struct CodeExplorerExerciseGenerator {
    
    private struct TargetFile: Codable {
        let path: String
        let contents: String
    }

    private struct Response: Codable {
        let targetFiles: [TargetFile]
    }

    public enum TargetPathname: String, CaseIterable {
        case instructions = "instructions.txt"
        case expectedOutput = "expectedOutput.txt"
        case prepend = "prependSourceCode.txt"
        case append = "appendSourceCode.txt"
    }

    public class DynamicResponse {
        private var targetFilesDictionary = [String: String]()

        public init() {
            for targetPathname in TargetPathname.allCases {
                targetFilesDictionary[targetPathname.rawValue] = String()
            }
        }

        public func appendLine(_ line: String, to targetPathname: TargetPathname) {
            targetFilesDictionary[targetPathname.rawValue]!.append(line + "\n")
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
} 

