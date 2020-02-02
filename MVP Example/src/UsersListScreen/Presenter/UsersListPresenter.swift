import Foundation

protocol UsersListPresenterProtocol: class {
    init(view: UsersListViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol)
    var users: [User]? { get set }
    func loadUsers()
    func showDetails(user: User?)
}

class UsersListPresenter: UsersListPresenterProtocol {
    private weak var view: UsersListViewProtocol?
    private let networkManager: NetworkManagerProtocol!
    var users: [User]?
    private var router: RouterProtocol?
    
    required init(view: UsersListViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
    }
    
    func loadUsers() {
        networkManager.loadUsers { [weak self] result in
            guard let self = self else { return }
            
                switch result {
                case .success(let users):
                    self.users = users
                    self.view?.update()
                case .failure(let error):
                    self.view?.showErrorWith(text: error.localizedDescription)
                }
        }
    }
    
    func showDetails(user: User?) {
        router?.showDetail(user: user)
    }
}
