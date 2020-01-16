//
//  ChangelogItemTests.swift
//  ChangelogProducerTests
//
//  Created by Antoine van der Lee on 16/01/2020.
//

import XCTest
@testable import ChangelogProducerCore

final class ChangelogItemTests: XCTestCase {

    /// It should return `nil` if there's no title.
    func testNilTitle() {
        let item = ChangelogItem(input: MockChangelogInput(), closedBy: MockChangelogInput())
        XCTAssertNil(item.title)
    }

    /// It should correctly display the number and URL.
    func testNumberURL() {
        let input = MockChangelogInput(number: 1, title: UUID().uuidString, htmlURL: URL(string: "https://www.fakeurl.com")!)
        let item = ChangelogItem(input: input, closedBy: MockChangelogInput())
        XCTAssertEqual(item.title, "\(input.title!) ([#1](https://www.fakeurl.com))")
    }

    /// It should show the user if possible.
    func testUser() {
        let input = MockChangelogInput(title: UUID().uuidString, username: "Henk")
        let item = ChangelogItem(input: input, closedBy: input)
        XCTAssertEqual(item.title, "\(input.title!) via @Henk")
    }

    /// It should combine the title, number and user.
    func testTitleNumberUser() {
        let input = MockChangelogInput(number: 1, title: UUID().uuidString, htmlURL: URL(string: "https://www.fakeurl.com")!)
        let closedBy = MockChangelogInput(username: "Henk")
        let item = ChangelogItem(input: input, closedBy: closedBy)
        XCTAssertEqual(item.title, "\(input.title!) ([#1](https://www.fakeurl.com)) via @Henk")
    }

}
