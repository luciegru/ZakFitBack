import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get("test-db") { req async throws -> String in
        let count = try await User.query(on: req.db).count()
        return "Connected! Users in DB: \(count)"
    }

//    try app.register(collection: TodoController())
}
