import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "O Kurwa!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
}
