import UIKit

protocol UsersListViewProtocol: class {
    func update()
    func showErrorWith(text: String)
}

class UsersListViewController: LoadingViewController {
    
    var presenter: UsersListPresenterProtocol!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Users"
        
        tableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showActivityIndicator(for: tableView)
        
        presenter.loadUsers()
    }
}

extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier(), for: indexPath) as! UserTableViewCell
        
        if let user = presenter.users?[indexPath.row] {
            cell.updateWith(model: UserTableViewCellModel(user: user))
        }
        
        return cell
    }
}

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = presenter.users?[indexPath.row] else { return }
        
        presenter.showDetails(user: user)
    }
}

extension UsersListViewController: UsersListViewProtocol {
    func update() {
        hideActivityIndicator()
        tableView.reloadData()
    }
    
    func showErrorWith(text: String) {
        hideActivityIndicator()
        showAlert(withTitle: nil, message: text)
    }
}

