import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get("test-db") { req async throws -> String in
        let count = try await User.query(on: req.db).count()
        return "Connected! Users in DB: \(count)"
    }

    try app.register(collection: UserController())

    try app.register(collection: APController())

    try app.register(collection: UserAPController())

    try app.register(collection: WeightObjectiveController())
    
    try app.register(collection: APObjectiveController())
    
    try app.register(collection: DailyCalObjectiveController())
    
    try app.register(collection: UserWeightController())
    
    try app.register(collection: FoodPreferencesController())
    
    try app.register(collection: UserFoodPreferenceController())
    
    try app.register(collection: FoodCategoryController())
    
    try app.register(collection: FoodController())
    
    try app.register(collection: MealController())
    
    try app.register(collection: MealFoodController())

}
