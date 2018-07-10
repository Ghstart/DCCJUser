import XCTest
import DCCJUser

class Tests: XCTestCase {
    
    private let user = DCCJUser()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetToken() {
        self.user.setToken("newToken", callback: nil)
        XCTAssert(self.user.getToken() == "newToken")
    }
    
    func testGetTokenFromUserDefault() {
        XCTAssert(self.user.getToken() == "newToken")
    }
    
    func testRemoveToken() {
        self.user.setToken("", callback: nil)
        XCTAssert(self.user.getToken() == "")
    }
    
    func testGetTokenFromUserDefaultAgain() {
        print(self.user.getToken())
        XCTAssert(self.user.getToken() == "")
    }
    
    func testSetTokenAgain() {
        self.user.setToken("secondToken", callback: nil)
        XCTAssert(self.user.getToken() == "secondToken")
    }
}
