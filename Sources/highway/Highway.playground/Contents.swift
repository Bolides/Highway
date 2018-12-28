import Cocoa
import JWT
import CupertinoJWT
import ZFile

//: # Highway

var claims = ClaimSet()
claims.issuer = "me"
claims.expiration = Date(timeIntervalSinceNow: 520)

let secret = """
-----BEGIN PRIVATE KEY-----
MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgqefzLfbdOUoy9SLJ
fYlEam89LJ9ECMSUFcqakYBFcXOgCgYIKoZIzj0DAQehRANCAAQZGBLSE/fa1xZ6
sy9kfYwdARFpV75f6Fm1yClqPJR1uuBIKpofL5lZMFZFRyHVZjXmoSE126u5DNvU
Rk3L4IKW
""".data(using: .utf8)!

let encoded = JWT.encode(claims: claims, algorithm: .hs512(secret))

let currentFolder = FileSystem.shared.currentFolder

//: # Cupertino JWT

// Get content of the .p8 file
let p8 = 

// Assign developer information and token expiration setting
let jwt = JWT(keyID: keyID, teamID: teamID, issueDate: Date(), expireDuration: 60 * 60)

do {
    let token = try jwt.sign(with: p8)
    // Use the token in the authorization header in your requests connecting to Apple’s API server.
    // e.g. urlRequest.addValue(_ value: "bearer \(token)", forHTTPHeaderField field: "authorization")
} catch {
    // Handle error
}

