//
//  프린터큐.swift
//  DataStructures
//
//  Created by 양호준 on 7/20/25.
//

import Foundation

func printerQueue() {
    let problemCount = Int(readLine()!)!

    for _ in 0..<problemCount {
        let elementInfo = readLine()!.split(separator: " ").map { Int($0)! }
    //    let elementCount = elementInfo[0]
        let targetIndex = elementInfo[1]
        let elements = readLine()!.split(separator: " ").map { Int($0)! }

        let queue = makeQueue(elements: elements)
        var dequeueStorage = [Node<Int>]()
        
        while queue.list.head != nil {
            guard let node = queue.dequeue() else { break }
            var hasHigherPriority = false

            var currentNode = queue.list.head
            while let current = currentNode {
                if current.value > node.value {
                    hasHigherPriority = true
                    break
                }
                currentNode = current.next
            }
            if hasHigherPriority {
                queue.enqueue(value: node.value, index: node.index)
            } else {
                dequeueStorage.append(node)
                if dequeueStorage.last?.index ?? .min == targetIndex {
                    break
                }
            }
        }

        print(dequeueStorage.count)
    }

    final class Node<T: Equatable>: Equatable {
        static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
            lhs.value == rhs.value && lhs.next == rhs.next
        }

        let value: T
        var next: Node?
        var index: Int

        init(value: T, index: Int) {
            self.value = value
            self.next = nil
            self.index = index
        }
    }

    final class LinkedList<T: Equatable> {
        var head: Node<T>?
        var tail: Node<T>?

        /// 마지막에 노드 추가 - O(1)
        func offer(value: T, index: Int) {
            let node = Node(value: value, index: index)
            if let tailNode = tail {
                tailNode.next = node
                tail = node
            } else { // 아무 node도 없는 경우
                head = node
                tail = node
            }
        }

        /// 첫 노드를 빼냄 - O(1)
        func poll() -> Node<T>? {
            let result = head
            if let next = head?.next {
                head = next
            } else {
                head = nil
                tail = nil
            }

            return result
        }
    }

    final class Queue<T: Equatable> {
        var list = LinkedList<T>()

        func enqueue(value: T, index: Int) {
            list.offer(value: value, index: index)
        }

        func dequeue() -> Node<T>? {
            return list.poll()
        }
    }

    func makeQueue(elements: [Int]) -> Queue<Int> {
        let queue = Queue<Int>()
        elements.enumerated().forEach { (index, element) in
            queue.enqueue(value: element, index: index)
        }
        return queue
    }

}
