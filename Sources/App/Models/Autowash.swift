import Vapor

final class Autowash: Model {

    var id: Node?
    var exists: Bool = false
    
    var name: String
    var address: String
    var phone: String
    
    static var entity = "autowashs"
    
    init(name: String, address: String, phone: String) {
        self.id = nil
        self.name = name
        self.address = address
        self.phone = phone

    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        address = try node.extract("address")
        phone = try node.extract("phone")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "address": address,
            "phone:": phone
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(entity) { users in
            users.id()
            users.string("name")
            users.string("address")
            users.string("phone")
        }
    }
    
    
    static func revert(_ database: Database) throws {
        try database.delete(entity)
    }
    
}
