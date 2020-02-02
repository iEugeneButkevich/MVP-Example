import UIKit

protocol BaseRouter {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

protocol RouterProtocol: BaseRouter {
    func setInitialViewController()
    func showDetail(user: User?)
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func setInitialViewController() {
        guard let navigationController = navigationController,
            let initialViewController = moduleBuilder?.createInitialModule(router: self) else { return }
        
        navigationController.viewControllers = [initialViewController]
    }
    
    func showDetail(user: User?) {
        guard let navigationController = navigationController,
            let userDetailsViewController = moduleBuilder?.createUserDetailsModule(user: user) else { return }
        
        navigationController.pushViewController(userDetailsViewController, animated: true)
    }
}
