import XCTest

@testable import MVP_Example

fileprivate class MockView: UserDetailsViewProtocol {
    
    var user: User?
    
    func showInfoFor(user: User?) {
        self.user = user
    }
}

class UserDetailsPresenterTest: XCTestCase {

    private var mockVew: MockView!
    private var networkManager: NetworkManagerProtocol!
    
    private var presenter: UserDetailsPresenterProtocol!
    private var user: User!
    
    override func setUp() {
        mockVew = MockView()
        networkManager = NetworkManager()
    }

    override func tearDown() {
        mockVew = nil
        networkManager = nil
    }

    func testSetUser() {
        let user = User(id: 33, firstName: "Some first name", lastName: "Some last name", email: "Some email", avatar: "")
        presenter = UserDetailsPresenter(view: mockVew, networkManager: networkManager, user: user)
        
        presenter.setUser()
        
        XCTAssertNotNil(mockVew.user)
        XCTAssertEqual(mockVew.user, user)
    }
}
