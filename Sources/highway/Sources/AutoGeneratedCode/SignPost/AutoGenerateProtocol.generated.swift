// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


//: Do not change this code as it is autogenerated every time you build.
//: You can change the code in `../StencilTemplatesForSourcery/Application/AutoGenerateProtocol
import Foundation

// MARK: - AutoGenerateProtocol
//: From all Types implementing this protocol Sourcery adds:
//: - public/internal variables // private variables are ignored
//: - public/internal methods (skips initializers)
//: - initializers marked with annotation // sourcery:includeInitInProtocol
//: - of the above it does not add it if  // sourcery:skipProtocol
//: ---





// Generated protocol inline for SignPost -> See code in the file of that type
    // sourcery:inline:SignPost.AutoGenerateProtocol
    static var shared: SignPostProtocol { get }
    var verbose: Bool { get }

    func write(printer: Printer)
    func write(printable: Printable)
    // sourcery:"Always printed as error"
    func error(_ text: String)
    func success(_ text: String)
    func message(_ text: String)
    // sourcery:"Prints text only if --verbose is set."
    func verbose(_ text: String)
    func print(_ printable: Printable)
    func verbosePrint(_ printable: Printable)
    // sourcery:end
// Generated protocol inline for  -> See code in the file of that type

// Generated protocol inline for  -> See code in the file of that type

// Generated protocol inline for  -> See code in the file of that type

// Generated protocol inline for  -> See code in the file of that type

// Generated protocol inline for  -> See code in the file of that type

// Generated protocol inline for  -> See code in the file of that type

// Generated protocol inline for  -> See code in the file of that type

// Generated protocol inline for  -> See code in the file of that type

// Generated protocol inline for  -> See code in the file of that type

// Generated protocol inline for  -> See code in the file of that type

// Generated protocol inline for  -> See code in the file of that type

