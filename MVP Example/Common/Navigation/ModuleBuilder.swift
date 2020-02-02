import UIKit

protocol ModuleBuilderProtocol {
    func createInitialModule(router: RouterProtocol) -> UIViewController
    func createUserDetailsModule(user: User?) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {

    func createInitialModule(router: RouterProtocol) -> UIViewController {
        let view = UsersListViewController()
        let presenter = UsersListPresenter(view: view, networkManager: NetworkManager(), router: router)
        view.presenter = presenter
        
        return view
    }
    
    func createUserDetailsModule(user: User?) -> UIViewController {
        let view = UserDetailsViewController()
        let presenter = UserDetailsPresenter(view: view, networkManager: NetworkManager(), user: user)
        view.presenter = presenter
        
        return view
    }
}
