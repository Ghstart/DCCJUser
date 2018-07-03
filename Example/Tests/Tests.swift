import XCTest
import DCCJUser

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetToken() {
        DCCJUser.setToken("newToken", callback: nil)
        XCTAssert(DCCJUser.getToken() == "newToken")
    }
    
    func testGetTokenFromUserDefault() {
        XCTAssert(DCCJUser.getToken() == "newToken")
    }
    
    func testRemoveToken() {
        DCCJUser.setToken("", callback: nil)
        XCTAssert(DCCJUser.getToken() == "")
    }
    
    func testGetTokenFromUserDefaultAgain() {
        print(DCCJUser.getToken())
        XCTAssert(DCCJUser.getToken() == "")
    }
    
    func testSetTokenAgain() {
        DCCJUser.setToken("secondToken", callback: nil)
        XCTAssert(DCCJUser.getToken() == "secondToken")
    }
}
