import XCTest

@testable import MVP_Example

fileprivate class MockView: UsersListViewProtocol {
    
    var errorDescription: String!
    
    func update() {
        
    }
    
    func showErrorWith(text: String) {
        errorDescription = text
    }
}

fileprivate class MockNetworkManager: NetworkManagerProtocol {
    
    var users: [User]!
    var error: NSError!
    
    convenience init(users: [User]?) {
        self.init()
        self.users = users
    }
    
    func loadUsers(completion: @escaping (Result<[User]?, Error>) -> Void) {
        if let users = users {
            completion(.success(users))
        } else {
            completion(.failure(error))
        }
    }
}

class UsersListPresenterTest: XCTestCase {
    
    private var mockVew: MockView!
    private var presenter: UsersListPresenterProtocol!
    private var mockNetworkManager: MockNetworkManager!
    private var router: RouterProtocol!
    private var users: [User]!

    override func setUp() {
        mockVew = MockView()
        router = Router(navigationController: UINavigationController(), moduleBuilder: ModuleBuilder())
    }

    override func tearDown() {
        mockVew = nil
        mockNetworkManager = nil
        presenter = nil
    }

    func testSuccessLoadUsers() {
        let user = User(id: 33, firstName: "Some first name", lastName: "Some last name", email: "Some email", avatar: "")
        
        mockNetworkManager = MockNetworkManager(users: [user])
        presenter = UsersListPresenter(view: mockVew, networkManager: mockNetworkManager, router: router)
        
        presenter.loadUsers()
        
        XCTAssertNotNil(presenter.users)
        XCTAssertNotEqual(presenter.users?.count, 0)
        XCTAssertEqual(presenter.users, [user])
    }
    
    func testFailureLoadUsers() {
        mockNetworkManager = MockNetworkManager(users: nil)
        mockNetworkManager.error = NSError(domain: "SomeError", code: 333, userInfo: [:])
        presenter = UsersListPresenter(view: mockVew, networkManager: mockNetworkManager, router: router)
        
        presenter.loadUsers()
        
        XCTAssertNotNil(mockVew.errorDescription)
        XCTAssertEqual(mockNetworkManager.error.localizedDescription, mockVew.errorDescription)
    }
}
