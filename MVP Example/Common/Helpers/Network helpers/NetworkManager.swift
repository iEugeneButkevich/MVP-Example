import Foundation

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}

protocol NetworkManagerProtocol {
    func loadUsers(completion: @escaping (Result<[User]?, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func loadUsers(completion: @escaping (Result<[User]?, Error>) -> Void) {
        let urlString = "https://reqres.in/api/users"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "Ooops", code: 666, userInfo: nil)))
                    return
                }
                
                do {
                    let users = try UserDecoder().decode(data: data)
                    
                    completion(.success(users))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
