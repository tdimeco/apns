import Foundation

extension URL {
    
    /// Read the content of the given file URL.
    ///
    /// - Returns: The file content as text.
    func readContent() async throws -> String {
        let fileHandler = try FileHandle(forReadingFrom: self)
        return try await fileHandler.bytes.lines.reduce(into: []) { $0.append($1) }.joined(separator: "\n")
    }
}
