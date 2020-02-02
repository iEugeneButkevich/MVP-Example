import Foundation

protocol UserDetailsPresenterProtocol: class {
    init(view: UserDetailsViewProtocol, networkManager: NetworkManagerProtocol, user:User?)
    func setUser()
}

class UserDetailsPresenter: UserDetailsPresenterProtocol {
    
    private weak var view: UserDetailsViewProtocol?
    private let networkManager: NetworkManagerProtocol!
    private var user: User?
    
    required init(view: UserDetailsViewProtocol, networkManager: NetworkManagerProtocol, user: User?) {
        self.view = view
        self.networkManager = networkManager
        self.user = user
    }
    
    func setUser() {
        self.view?.showInfoFor(user: user)
    }
}
