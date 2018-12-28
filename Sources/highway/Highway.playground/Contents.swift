import Cocoa
import JWT

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
