import Foundation
import UIKit

class URLService {
    let APIKey: String = "de90f94f39c65c15d15b072e0ef2a493"
    let session = URLSession.shared
    let parser = JSONParsingService()
    var imageCache = NSCache<NSString, UIImage>()

    
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
    
    func getSetPoster(url: URL, completion: @escaping (UIImage) -> Void) {
            
       if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
           completion(cachedImage)
       } else {
           let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
                
           let downloadingTask = session.dataTask(with: request) { [weak self] data, response, error in
                    
               guard error == nil,
               let unwrData = data,
               let response = response as? HTTPURLResponse, response.statusCode == 200,
               let `self` = self else {
                  return
               }
                    
               guard let image = UIImage(data: unwrData) else {
                  return
               }
               self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    
               DispatchQueue.main.async {
                   completion(image)
               }
            }
            downloadingTask.resume()
          }
    }
}

