import Foundation

class URLService {
    let APIKey: String = "de90f94f39c65c15d15b072e0ef2a493"
    let APIURL: URL
    let session = URLSession.shared
    
    init(category: String) {
        APIURL = URL(string: "https://api.themoviedb.org/3/movie/\(category)?api_key=\(APIKey)&language=en-US&page=1")!
    }
    
    func dataRequest() {
        let task = session.dataTask(with: APIURL) { data, response, error in
            guard let unwrData = data,
                  let dataString = String(data: unwrData, encoding: .utf8),
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil else { return }
            print(dataString)
        }
        task.resume()
    }
}
