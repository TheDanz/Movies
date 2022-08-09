import Foundation

class URLService {
    let APIKey: String = "de90f94f39c65c15d15b072e0ef2a493"
    let session = URLSession.shared
    let parser = JSONParsingService()
    
    func dataRequest() {
        guard let APIURL: URL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(APIKey)&language=en-US&page=1") else { return }
        
        let task = session.dataTask(with: APIURL) { data, response, error in
            guard let unwrData = data,
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil else { return }
            self.parser.parseJSON(parseData: unwrData, parseError: error)
        }
        task.resume()
    }
}
