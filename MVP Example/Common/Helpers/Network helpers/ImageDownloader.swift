import UIKit

class ImageDownloader {
    
    static let shared = ImageDownloader()
    
    private init() { }
    
    func downloadImage(url:String, completion:@escaping (String, UIImage?) -> Void) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        
        downloadImageWith(session: session, url: url, completion: completion)
    }
    
    func downloadImageUsingCache(url:String, completion:@escaping (String, UIImage?) -> Void) {
        downloadImageWith(session: URLSession.shared, url: url, completion: completion)
    }
    
    private func downloadImageWith(session:URLSession, url:String, completion:@escaping (String, UIImage?) -> Void) {
        guard let imageUrl = URL(string: url) else {
            completion(url, nil)
            return
        }
        
        session.dataTask(with: imageUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let httpUrlReponse = response as? HTTPURLResponse, httpUrlReponse.statusCode == 200,
                    let data = data, error == nil, let image = UIImage(data: data)
                    else {
                        completion(url, nil)
                        return
                }
                
                completion(url, image)
            }
        }.resume()
    }
}
