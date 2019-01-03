import Cocoa
// import CupertinoJWT
// import ZFile
// import os
//
// let currentFolder = FileSystem.shared.currentFolder
//
////: # Cupertino JWT
//
// do {
//    // Get content of the .p8 file
//    let p8 = try currentFolder.file(named: "/Sources/AutomateHighway/AuthKey_VV7NT37UVU.p8").readAsString()
//
//    // Assign developer information and token expiration setting
//    let keyID = ""
//    let teamID = ""
//    let issueDate = Date()
//    let expireDuration: TimeInterval = 60 * 60
//
//    let jwt = CupertinoJWT.JWT(keyID: keyID, teamID: teamID, issueDate: issueDate, expireDuration: expireDuration)
//
//
//    let token = try jwt.sign(with: p8)
//    // Use the token in the authorization header in your requests connecting to Apple’s API server.
//    // e.g. urlRequest.addValue(_ value: "bearer \(token)", forHTTPHeaderField field: "authorization")
//    os_log(.info, "💁🏻‍♂️ token: \n%@/n", "\(token)")
//
// } catch {
//    // Handle error
//    os_log(.error, "⚠️ \n%@/n", "\(error)")
//    os_log(.info, "💁🏻‍♂️ maybe run 'git-secret reveal first ...")
// }
