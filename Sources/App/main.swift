import Vapor
import VaporPostgreSQL

let drop = Droplet()
try drop.addProvider(VaporPostgreSQL.Provider)
drop.preparations += Autowash.self


drop.get("hello") { request in
    return "Hello, world!"
}

drop.get("version") { req in
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let version = try db.raw("SELECT  version()")
        return try JSON(node: version)
    } else {
        return "No db connection"
    }
}

drop.get("test") { request in
    var autowash = Autowash(name: "AFK", address: "Away From Keyboard", phone: "TMT")
    try autowash.save()
    return try JSON(node: Autowash.all().makeNode())
}

drop.run()
