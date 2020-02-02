import UIKit

protocol UserDetailsViewProtocol: class {
    func showInfoFor(user: User?)
}

class UserDetailsViewController: UIViewController {

    var presenter: UserDetailsPresenterProtocol!
    
    @IBOutlet private weak var avatarImageView: LoadingImageView!
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.setUser()
    }
}

extension UserDetailsViewController:UserDetailsViewProtocol {
    func showInfoFor(user: User?) {
        avatarImageView.updateWith(url: user?.avatar)
        firstNameLabel.text = user?.firstName
        lastNameLabel.text = user?.lastName
        emailLabel.text = user?.email
    }
}
