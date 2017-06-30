import Kitura
import Foundation

// Create a Router that we can use to create REST endpoints
let router = Router()

var latestImage: Data? = nil

// Create a GET endpoint: http://localhost:8090/latestImage
router.get("/latestImage") {
    request, response, next in
    
    defer { next() }
    
    guard let image = latestImage else {
        response.status(.preconditionFailed).send("No image is available")
        return
    }
    
    response.send(data: image)
}

// Create a POST endpoint: http://localhost:8090/image
router.post("/image") {
    request, response, next in
    
    defer { next() }
    
    var imageData = Data()
    
    do {
        // Read the body of the request into the data object
        try _ = request.read(into: &imageData)
        latestImage = imageData
        response.status(.OK)
            .send("Image received")
    } catch(let error) {
        response.status(.internalServerError)
            .send("Something went wrong when reading the image data")
    }
}

// Specify that we want an HTTP server that we can reach with http://localhost:8090
Kitura.addHTTPServer(onPort: 8090, with: router)


// Start the server
Kitura.run()
