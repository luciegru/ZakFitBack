import NIOSSL
import Fluent
import FluentMySQLDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {

    app.http.server.configuration.hostname = "127.0.0.1"
    app.http.server.configuration.port = 8080

    // Formatter for dates like "yyyy/MM/dd"
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(formatter)
    
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .formatted(formatter)
    
    ContentConfiguration.global.use(decoder: decoder, for: .json)
    ContentConfiguration.global.use(encoder: encoder, for: .json)


    app.databases.use(DatabaseConfigurationFactory.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? 3306,
        username: Environment.get("DATABASE_USERNAME") ?? "root",
        password: Environment.get("DATABASE_PASSWORD") ?? "",
        database: Environment.get("DATABASE_NAME") ?? "ZakFit"
    ), as: .mysql)

    app.migrations.add(CreateTodo())

    // register routes
    try routes(app)
    
    
    //CORS
    let corsConfiguration = CORSMiddleware.Configuration(
//        allowedOrigin: .custom("mettre le bon domaine"),
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .PATCH, .DELETE, .OPTIONS],
        allowedHeaders: [.accept, .authorization, .contentType, .origin],
        cacheExpiration: 5
    )
    
    let cors = CORSMiddleware(configuration: corsConfiguration)
    app.middleware.use(cors)

}
