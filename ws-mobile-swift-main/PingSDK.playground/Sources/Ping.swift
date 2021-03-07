import Foundation
import PlaygroundSupport

func log(
    api: String,
    lat: Double = 0.0,
    lon: Double = 0.0,
    time: Int64 = 0, // epoch timestamp in seconds
    ext: String = "", // extra text payload
    callback: @escaping (Any) -> Void
) {
    let payload: [String: Any] = [
        "lat": lat,
        "lon": lon,
        "time": time,
        "ext": ext,
    ]

    if lat == 0.0 || lon == 0.0 {
        return callback("Please send your current location.")
    }
    
    URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
    PlaygroundPage.current.needsIndefiniteExecution = true

    let jsonData = try? JSONSerialization.data(withJSONObject: payload)

    // create post request
    let url = URL(string: api)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    // insert json data to the request
    request.httpBody = jsonData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            return callback(error?.localizedDescription ?? "No data")
        }
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
            print(responseJSON)
            return callback(payload)
        }
    }
    
    task.resume()
        
    PlaygroundPage.current.finishExecution()
}
