import XCTest

@testable import MVP_Example

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
}

class RouterTest: XCTestCase {
    
    private var router: RouterProtocol!
    private let mockNavigationController = MockNavigationController()
    private let moduleBuilder = ModuleBuilder()

    override func setUp() {
        router = Router(navigationController: mockNavigationController, moduleBuilder: moduleBuilder)
    }

    override func tearDown() {
        router = nil
    }

    func testRouter() {
        router.showDetail(user: nil)
        let detailsViewController = mockNavigationController.presentedVC
        XCTAssertTrue(detailsViewController is UserDetailsViewController)
    }
}
