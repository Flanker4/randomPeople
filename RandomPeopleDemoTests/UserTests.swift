//
//  UserTests.swift
//  RandomPeopleDemo
//
//  Created by aboyko on 5/29/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import RandomPeopleDemo


class UserTests: XCTestCase {
    let userJSON: String = "{\"gender\":\"female\",\"name\":{\"title\":\"miss\",\"first\":\"nalan\",\"last\":\"akaydın\"},\"location\":{\"street\":\"7922 doktorlar cd\",\"city\":\"balıkesir\",\"state\":\"ankara\",\"postcode\":98152},\"email\":\"nalan.akaydın@example.com\",\"login\":{\"username\":\"lazykoala210\",\"password\":\"bighead\",\"salt\":\"wf0YkyEM\",\"md5\":\"dcbd0c6ec2e0aecbff5c3887140d354c\",\"sha1\":\"e96bec04406fa1bc5e30d5c6b0803e14966dc66c\",\"sha256\":\"0379c66daa605a8e47d091ba18cd4cef0a7f74ac2fbd98ad010ab2c30b6170f3\"},\"dob\":\"1947-12-04 00:12:17\",\"registered\":\"2005-10-17 15:52:23\",\"phone\":\"(305)-060-9170\",\"cell\":\"(592)-239-8004\",\"id\":{\"name\":\"\",\"value\":null},\"picture\":{\"large\":\"https://randomuser.me/api/portraits/women/25.jpg\",\"medium\":\"https://randomuser.me/api/portraits/med/women/25.jpg\",\"thumbnail\":\"https://randomuser.me/api/portraits/thumb/women/25.jpg\"},\"nat\":\"TR\"}"

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMap() {
        let user = Mapper<User>().map(JSONString: userJSON)
        XCTAssertNotNil(user)
        XCTAssertNotNil(user?.objectId)

        XCTAssert(user?.gender == .female)
        XCTAssertEqual(user?.firstName, "nalan")
        XCTAssertEqual(user?.lastName, "akaydın")
        XCTAssertEqual(user?.email, "nalan.akaydın@example.com")
        XCTAssertEqual(user?.pictureThumbnail, URL(string: "https://randomuser.me/api/portraits/thumb/women/25.jpg"))
        XCTAssertEqual(user?.pictureLarge, URL(string: "https://randomuser.me/api/portraits/women/25.jpg"))
    }

    func testMapRequiredProperties() {
        var JSON = Mapper<User>.parseJSONStringIntoDictionary(JSONString: userJSON)

        JSON?[UserKeys.email.key] = nil
        let user = Mapper<User>().map(JSON: JSON!)
        XCTAssertNil(user)
    }

    func testMapOptionalProperties() {
        var JSON = Mapper<User>.parseJSONStringIntoDictionary(JSONString: userJSON)
        var pictures = JSON?[UserKeys.picture.key] as? [String: Any]

        pictures?[UserKeys.thumbnail.key] = nil
        JSON?[UserKeys.picture.key] = pictures

        let user = Mapper<User>().map(JSON: JSON!)
        XCTAssertNotNil(user)
        XCTAssertNil(user?.pictureThumbnail)
    }
}
