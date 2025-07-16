import Foundation


protocol Queue {
    associatedtype Element // Element가 다른 타입이 될 수 있기 때문에 Associated Type 사용
    
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

protocol QueueDescribing {
    associatedtype T
    func enqueue(node: T)
    func dequeue() -> T?
    func insert(at index: Int, node: T)
}

final class Node<T: Equatable>: Equatable {
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        lhs.value == rhs.value && lhs.next == rhs.next && lhs.prior == rhs.prior
    }
    
    let value: T
    var prior: Node?
    var next: Node?

    init(value: T) {
        self.value = value
        self.prior = nil
        self.next = nil
    }
}

final class LinkedList<T: Equatable> {
    var head: Node<T>?
    var tail: Node<T>?
    var count = 0

    /// 마지막에 노드 추가 - O(1)
    func offer(node: Node<T>) {
        if let tailNode = tail {
            tailNode.next = node
            node.prior = tailNode
            tail = node
        } else {
            head = node
            tail = node
        }
        count += 1
    }

    /// 첫 노드를 빼냄 - O(1)
    func poll() -> Node<T>? {
        let result = head
        if let next = head?.next {
            next.prior = nil
            head = next
        } else {
            removeAll()
        }

        return head
    }

    /// 중간에 노드 삽입 - O(n)
    func set(at index: Int, node: Node<T>) {
        var currentNode = head
        for i in 0...count {
            if index == i {
                if currentNode == nil {
                    // 마지막 노드 추가
                    tail?.next = node
                    node.prior = tail
                    tail = node
                } else if currentNode?.prior == nil {
                    // 첫 노드 추가
                    head?.prior = node
                    node.next = head
                    head = node
                } else {
                    // 중간 노드 추가
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

    func removeLast() -> Node<T>? {
        let result = tail

        if let prior = result?.prior {
            prior.next = nil
            tail = prior
        } else {
            removeAll()
        }

        return tail
    }

    func removeAll() {
        head = nil
        tail = nil
    }

    func isEmpty() -> Bool {
        head == nil && tail == nil
    }

    func printList() {
        var currentNode = head
        while currentNode != nil {
            print("value: \(currentNode?.value)\n  prior: \(currentNode?.prior) \n  next: \(currentNode?.next)")
            currentNode = currentNode?.next
        }
    }
}

final class Queue2<T: Equatable>: QueueDescribing {
    var list = LinkedList<T>()
    
    func enqueue(node: Node<T>) {
        list.offer(node: node)
    }
    
    func dequeue() -> Node<T>? {
        return list.poll()
    }
    func insert(at index: Int, node: Node<T>) {
        list.set(at: index, node: node)
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
