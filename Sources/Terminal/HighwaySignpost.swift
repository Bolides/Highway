import Foundation
import Task
import SourceryAutoProtocols

public protocol HighwaySignpostProtocol: AutoMockable {
    /// sourcery:inline:HighwaySignpost.AutoGenerateProtocol
    static var shared: HighwaySignpost { get }
    var verbose: Bool { get set }

    func log(_ text: String)
    func write(_ printer: Printer)
    func write(_ printable: Printable)
    func error(_ text: String)
    func success(_ text: String)
    func message(_ text: String)
    func verbose(_ text: String)
    func print(_ printable: Printable)
    func verbosePrint(_ printable: Printable)
    /// sourcery:end
}

// Use this class to delivers logs to the user.
public class HighwaySignpost: HighwaySignpostProtocol, AutoGenerateProtocol {
    // MARK: - Global
    public static let shared = HighwaySignpost()
    
    // MARK: - Init
    public init() { }
    
    // MARK: - Properties
    private let queue = DispatchQueue(label: "de.christian-kienle.highway.terminal")
    private var promptTemplate = Prompt.normal
    private let stream = FileStream(fd: stdout)
    public var verbose = false
    
    public func log(_ text: String) {
        rawLog("\r" + self.promptTemplate.terminalString + text + "\n")
    }
    private func rawLog(_ text: String) {
        _sync {
            stream.write(text)
        }
    }
    private func rawLogNl(_ text: String) {
        _sync {
            stream.write("\r" + text + "\n")
        }
    }
    // MARK: - Write Stuff
    public func write(_ printer: Printer) {
        _sync {
            self._write(printer)
        }
    }
    private func _write(_ printer: Printer) {
        let string = printer.string(with: .defaultOptions())
        stream.write(string)
    }
    
    public func write(_ printable: Printable) {
        _sync {
            self._write(printable)
        }
    }
    
    private func _write(_ printable: Printable) {
        let string = printable.printableString(with: .defaultOptions())
        stream.write(string)
    }
    
    // MARK: - Working with the Queue
    /// Execute handler on the terminal queue
    private func _sync(_ handler: ()->()) {
        queue.sync {
            handler()
        }
    }
}

fileprivate extension HighwaySignpost {
    func _withPrompt(_ text: String) -> String {
        return promptTemplate.terminalString + text
    }
}

extension HighwaySignpost: UIProtocol {
    
    public func error(_ text: String) {
        rawLogNl(_withPrompt(text))
    }
    public func success(_ text: String) {
        rawLogNl(_withPrompt(text))
    }
    
    public func message(_ text: String) {
        rawLogNl(_withPrompt(text))
    }
    
    public func verbose(_ text: String) {
        guard self.verbose else { return }
        rawLogNl(_withPrompt(text))
    }
    public func print(_ printable: Printable) {
        rawLog(printable.printableString(with: .defaultOptions()))
    }
    
    public func verbosePrint(_ printable: Printable) {
        guard self.verbose else { return }
        rawLog(printable.printableString(with: .defaultOptions()))
    }

}


