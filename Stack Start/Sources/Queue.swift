import Foundation


protocol Queue {
    associatedtype Element // Element가 다른 타입이 될 수 있기 때문에 Associated Type 사용
    
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

// Index Queue
struct IndexQueue<T> {
    var queue = [T]()
    var index = 0
    
    var isEmpty: Bool {
        return (queue.count - index) == 0 ? true : false
    }
    
    mutating func push(_ t: T) {
        queue.append(t)
    }
    
    mutating func pop() -> T {
        defer {
            index += 1
        }
        return queue[index]
    }
}

// Queue Array
struct QueueArray<T>: Queue {
    private var array: [T] = []
    var isEmpty: Bool {
        return array.isEmpty
    }
    var peek: T? {
        return array.first
    }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }
}

// Queue Stack
struct QueueStack<T>: Queue {
    private var dequeueStack: [T] = []
    private var enqueueStack: [T] = []
    
    var isEmpty: Bool {
        return dequeueStack.isEmpty && enqueueStack.isEmpty
    }
    
    var peek: T? {
        return !dequeueStack.isEmpty ? dequeueStack.last : enqueueStack.first
    }
    
    mutating func enqueue(_ element: T) {
        enqueueStack.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        return dequeueStack.popLast()
    }
}
