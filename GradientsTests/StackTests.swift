//
//  StackTests.swift
//  Gradients
//
//  Created by Andrea Gottardo on 2018-12-26.
//  Copyright © 2018 Andrea Gottardo. All rights reserved.
//

import XCTest

class StackTests: XCTestCase {

    let stack = Stack<String>()

    func testStack() {
        XCTAssertTrue(stack.count() == 0)
        XCTAssertTrue(stack.isEmpty())
        XCTAssertFalse(stack.hasMaxSize())
        XCTAssert(stack.peek() == nil)
        stack.push(item: "abc")
        XCTAssertEqual(stack.count(), 1)
        let abc = stack.pop()
        XCTAssert(abc == "abc")
        stack.push(item: "def")
        stack.push(item: "ghi")
        stack.push(item: "jkl")
        XCTAssertEqual(stack.count(), 3)
        XCTAssertFalse(stack.isEmpty())
        let jkl = stack.pop()
        XCTAssert(jkl == "jkl")
        XCTAssertEqual(stack.count(), 2)
        let ghi = stack.pop()
        XCTAssert(ghi == "ghi")
        XCTAssertEqual(stack.count(), 1)
        let def = stack.pop()
        XCTAssert(def == "def")
        XCTAssertEqual(stack.count(), 0)
        XCTAssertTrue(stack.isEmpty())
    }

}
