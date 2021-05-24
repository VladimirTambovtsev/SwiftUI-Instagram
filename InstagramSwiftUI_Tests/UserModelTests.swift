//
//  UserModelTests.swift
//  InstagramSwiftUI_Tests
//
//  Created by Владимир on 12.05.2021.
//

import XCTest
@testable import InstagramSwiftUI

class UserModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUser_WhenEmailIsProvided_ShouldBeTrue() throws {
        // Arrange
        let user = User(username: "username 1", email: "testnew@test.com", profileImageUrl: "https://some_image_url.com/image_id", fullname: "Test User")
        
        // Act
        
        // Assert
        XCTAssertTrue(user.username == "username 1", "Username is correct in User model")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
