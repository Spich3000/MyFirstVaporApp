import Vapor

// MARK: ROUTES
func routes(_ app: Application) throws {
    
    // Go to http://localhost:8080 to see "O Kurwa!"
    app.get { req async in
        "O Kurwa!"
    }
    
    // Go to http://localhost:8080/hello to see "Hello, world!"
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    // Go to http://localhost:8080/hello/vapor to see "Ja perdole!"
    app.get("hello","vapor") { req async -> String in
        "Ja perdole!"
    }
    
    // Go to http://localhost:8080/hello/Vasili to see "Hi, Vasili"
    app.get("hello", ":name") { req -> String in
        guard let name = req.parameters.get("name") else {
            throw Abort(.internalServerError)
        }
        return "Hi, \(name)"
    }
    
    // Go to http://localhost:8080/count/ebana to see number 5
    app.get("count", ":word") { req -> Int in
        guard let  word = req.parameters.get("word") else {
            throw Abort(.internalServerError)
        }
        return word.count
    }
    
    // Go to postman to make a POST request
    app.post("track") { req -> String in
        let data = try req.content.decode(Track.self)
        return "Listen to: \(data.artist) - \(data.title)"
    }
    
    // Send back ResponseTrack model in JSON on POST request
    app.post("track", "json") { req -> ResponseTrack in
        let data = try req.content.decode(Track.self)
        return ResponseTrack(request: data)
    }
    
}

// MARK: JSON STRUCT
struct Track: Content { // Content is like Codable
    let title: String
    let artist: String
}

// MARK: RESPONSE JSON STRUCT
struct  ResponseTrack: Content {
    let request: Track
}
