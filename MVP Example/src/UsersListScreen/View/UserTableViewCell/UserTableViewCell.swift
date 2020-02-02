import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var avatarImageView: LoadingImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    static func identifier() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: UserTableViewCell.identifier(), bundle: nil)
    }
    
    func updateWith(model: UserTableViewCellModelProtocol) {
        avatarImageView.updateWith(url: model.avatarUrlString, defaultImage: model.defaultImage)
        nameLabel.text = model.nameText
        emailLabel.text = model.emailText
    }    
}
