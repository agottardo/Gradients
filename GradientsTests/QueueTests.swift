//
//  QueueTests.swift
//  Gradients
//
//  Created by Andrea Gottardo on 2018-12-26.
//  Copyright © 2018 Andrea Gottardo. All rights reserved.
//

import XCTest

class QueueTests: XCTestCase {

    let queue = Queue<String>()

    func testQueue() {
        XCTAssertTrue(queue.count() == 0)
        XCTAssertTrue(queue.isEmpty())
        XCTAssertFalse(queue.hasMaxSize())
        XCTAssert(queue.next() == nil)
        queue.enqueue(item: "abc")
        XCTAssertEqual(queue.count(), 1)
        let abc = queue.dequeue()
        XCTAssert(abc == "abc")
        queue.enqueue(item: "def")
        queue.enqueue(item: "ghi")
        queue.enqueue(item: "jkl")
        XCTAssertEqual(queue.count(), 3)
        XCTAssertFalse(queue.isEmpty())
        let def = queue.dequeue()
        XCTAssert(def == "def")
        XCTAssertEqual(queue.count(), 2)
        let ghi = queue.dequeue()
        XCTAssert(ghi == "ghi")
        XCTAssertEqual(queue.count(), 1)
        let jkl = queue.dequeue()
        XCTAssert(jkl == "jkl")
        XCTAssertEqual(queue.count(), 0)
        XCTAssertTrue(queue.isEmpty())
    }

}
