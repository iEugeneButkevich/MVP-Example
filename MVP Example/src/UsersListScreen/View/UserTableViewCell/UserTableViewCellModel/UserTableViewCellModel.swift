import UIKit

protocol UserTableViewCellModelProtocol {
    var nameText: String { get }
    var emailText: String { get }
    var avatarUrlString: String { get }
    var defaultImage: UIImage { get }
}

struct UserTableViewCellModel: UserTableViewCellModelProtocol {
    var nameText: String
    var emailText: String
    var avatarUrlString: String
    var defaultImage = UIImage(named: "no_image")!

    init(user: User) {
        self.nameText = user.firstName + " " + user.lastName
        self.emailText = user.email
        self.avatarUrlString = user.avatar
    }
}
