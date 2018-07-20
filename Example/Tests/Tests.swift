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
        self.user.token = "newToken"
        XCTAssert(self.user.token == "newToken")
    }
    
    func testGetTokenFromUserDefault() {
        XCTAssert(self.user.token == "newToken")
    }
    
    func testRemoveToken() {
        self.user.token = ""
        XCTAssert(self.user.token == "")
    }
    
    func testGetTokenFromUserDefaultAgain() {
        print(self.user.token)
        XCTAssert(self.user.token == "")
    }
    
    func testSetTokenAgain() {
        self.user.token = "secondToken"
        XCTAssert(self.user.token == "secondToken")
    }
}
