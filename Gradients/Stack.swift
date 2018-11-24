//
//  Stack.swift
//  Gradients
//
//  Created by Andrea Gottardo on 2018-11-23.
//  Copyright © 2018 Andrea Gottardo. All rights reserved.
//

import Foundation

/**
 A LIFO data structure, supporting generics. User can set a constraint to the
 maximum number of items storable. Hello, Cinda! 👋
 */
class Stack<T> {
    
    /// The storage. Should be a LinkedList for maximum performance, using an
    /// array here for now.
    private var arr = [T]()
    
    /// Maximum number of elements (constraint).
    private var maxSize : Int?
    
    /// Adds an element to the stack.
    /// If the maximum number of elements has been set and reached, removes the
    /// oldest element to make room for the new element.
    /// - Parameter item: the element to add to the stack
    /// - Complexity: O(n), where n is the number of elements in the stack.
    func push(item: T) {
        if hasMaxSize() && count() + 1 > maxSize! {
            arr.removeLast()
        }
        arr.insert(item, at: 0)
    }
    
    /// Returns the last added element in the stack, without removing it.
    /// - Returns: nil if the stack is empty
    /// - Complexity: O(1)
    func peek() -> T? {
        guard !isEmpty() else {
            return nil
        }
        return arr.first
    }
    
    /// Removes the top element in the stack, and returns it.
    /// - Returns: nil if the stack is empty
    /// - Complexity: O(n), where n is the number of elements in the stack.
    func pop() -> T? {
        guard !isEmpty() else {
            return nil
        }
        return arr.removeFirst()
    }
    
    /// Returns the number of elements currently contained in the stack.
    /// - Complexity: O(1)
    func count() -> Int {
        return arr.count
    }
    
    /// Returns true if the stack is empty, false otherwise.
    /// - Complexity: O(1)
    func isEmpty() -> Bool {
        return count() == 0
    }
    
    /// Returns true if a constraint on the maximum number of elements allowed
    /// in the stack at any given time has been set, false otherwise.
    /// - Complexity: O(1)
    func hasMaxSize() -> Bool {
        return maxSize != nil
    }
    
    /// Sets a constraint on the maximum number of elements allowed in the
    /// stack at any given time.
    /// - Todo: Handle resize if is changed after a constraint has already been
    ///         set.
    /// - Parameter count: the constraint (# of elements)
    /// - Complexity: O(1)
    func setMaxSize(count: Int) {
        maxSize = count
    }
    
}
