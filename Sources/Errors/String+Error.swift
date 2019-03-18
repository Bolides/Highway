import Foundation
import ZFile

extension String: Swift.Error {}
extension String: LocalizedError
{
    public var errorDescription: String? { return self }
}

public typealias ErrorMessage = String

public func pretty_function(file: String = #file, function: String = #function, line: Int = #line, colomn: Int = #column, queue: Bool = Thread.isMainThread) -> String
{
    do
    {
        return "\(try File(path: file).name) \(function) (\(line), \(colomn)) mainQueue: \(queue)"
    }
    catch
    {
        return "\(file) (\(line), \(colomn)) mainQueue: \(queue)"
    }
}
