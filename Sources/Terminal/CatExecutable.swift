

import Foundation
import ZFile

struct CatExecutable: ArgumentExecutableProtocol
{
    let _argument: Arguments

    func executableFile() throws -> FileProtocol
    {
        return try File(path: "/bin/cat")
    }

    func arguments() throws -> Arguments
    {
        return _argument
    }
}
