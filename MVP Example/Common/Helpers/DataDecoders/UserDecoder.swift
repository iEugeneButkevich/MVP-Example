import Foundation

class UserDecoder {
    func decode(data: Data) throws -> [User]? {
        do {
            let dictionaryFromJSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            guard let jsonUser = dictionaryFromJSON["data"] as? NSArray else {
                throw NSError(domain: "Data is unavalaible", code: 404, userInfo: [:])
            }
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonUser, options: [])
            return try JSONDecoder().decode([User].self, from: jsonData!)
        } catch let error {
            throw error
        }
    }
}
