import Foundation


protocol Queue {
    associatedtype Element // Element가 다른 타입이 될 수 있기 때문에 Associated Type 사용
    
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

final class QueueElement {
    let value: Int
    var prior: QueueElement?
    var next: QueueElement?
    
    init(value: Int) {
        self.value = value
        self.prior = nil
        self.next = nil
    }
}

final class QueueWithLinkedList {
    var first: QueueElement?
    var last: QueueElement?
    var count: Int = 0
    
    // Node 한 개를 가진 Queue를 생성하는 경우
    init(node: QueueElement) {
        self.first = node
        self.last = node
        self.count = 1
    }
    
    func enqueue(node: QueueElement) {
        last?.next = node
        node.prior = last
        last = node
        count += 1
    }
    
    func dequeue() -> QueueElement? {
        guard count != 0 else { return nil }
        let result = first
        first = first?.next
        first?.prior = nil
        count -= 1
        return result
    }
    
    func peek() -> QueueElement? {
        return first
    }
    
    func isEmpty() -> Bool {
        return first == nil && last == nil
    }
    
    func insert(at index: Int, node: QueueElement) {
        var currentNode = first
        for i in 0...count {
            if index == i {
                if currentNode == nil {
                    last?.next = node
                    node.prior = last
                    last = node
                } else if currentNode?.prior == nil {
                    first?.prior = node
                    node.next = first
                    first = node
                } else {
                    node.next = currentNode
                    currentNode?.prior?.next = node
                    node.prior = currentNode?.prior
                }
                count += 1

                break
            }
            currentNode = currentNode?.next
        }
    }
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
