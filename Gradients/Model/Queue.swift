//
//  Queue.swift
//  Gradients
//
//  Created by Andrea Gottardo on 2018-12-26.
//  Copyright © 2018 Andrea Gottardo. All rights reserved.
//

import Foundation

/**
 A FIFO data structure, supporting generics. User can set a constraint to the
 maximum number of items storable.
 */
class Queue<T> {

    /// The storage. Should be a LinkedList for maximum performance, using an
    /// array here for now.
    private var arr = [T]()

    /// Maximum number of elements (constraint).
    private var maxSize: Int?

    /// Adds an element to the queue.
    /// If the maximum number of elements has been set and reached, removes the
    /// oldest element to make room for the new element.
    /// - Parameter item: the element to add to the queue
    /// - Complexity: O(n), where n is the number of elements in the queue.
    func enqueue(item: T) {
        if hasMaxSize() && count() + 1 > maxSize! {
            arr.removeFirst()
        }
        arr.append(item)
    }

    /// Removes the top element in the queue, and returns it.
    /// - Returns: nil if the queue is empty
    /// - Complexity: O(n), where n is the number of elements in the queue.
    func dequeue() -> T? {
        guard !isEmpty() else {
            return nil
        }
        return arr.removeFirst()
    }

    /// Returns the last added element in the queue, without removing it.
    /// - Returns: nil if the queue is empty
    /// - Complexity: O(1)
    func next() -> T? {
        guard !isEmpty() else {
            return nil
        }
        return arr.first
    }

    /// Returns the number of elements currently contained in the queue.
    /// - Complexity: O(1)
    func count() -> Int {
        return arr.count
    }

    /// Returns true if the queue is empty, false otherwise.
    /// - Complexity: O(1)
    func isEmpty() -> Bool {
        return count() == 0
    }

    /// Returns true if a constraint on the maximum number of elements allowed
    /// in the queue at any given time has been set, false otherwise.
    /// - Complexity: O(1)
    func hasMaxSize() -> Bool {
        return maxSize != nil
    }

    /// Sets a constraint on the maximum number of elements allowed in the
    /// queue at any given time.
    /// - Todo: Handle resize if is changed after a constraint has already been
    ///         set.
    /// - Parameter count: the constraint (# of elements)
    /// - Complexity: O(1)
    func setMaxSize(count: Int) {
        maxSize = count
    }

}
