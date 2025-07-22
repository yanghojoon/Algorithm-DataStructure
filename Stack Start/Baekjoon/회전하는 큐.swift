//
//  회전하는 큐.swift
//  DataStructures
//
//  Created by 양호준 on 7/22/25.
//

import Foundation

func circularQueue() {
    let firstInput = readLine()!.split(separator: " ").map({ Int($0)! })
    let size = firstInput[0]
    let dequeueCount = firstInput[1]
    let needToSelectedIndex = readLine()!.split(separator: " ").map({ Int($0)! })
    let queue = Queue<Int>()
    var dequeueResult = [Int]()

    for i in 1...size {
        queue.enqueue(value: i)
    }

    needToSelectedIndex.forEach { selectedIndex in
        let queueSize = size - dequeueResult.count
        var currentNode = queue.list.head
        var currentIndex = 0

        while let current = currentNode {
            if current.value == selectedIndex {
                if currentIndex == .zero { // 제일 앞에 있으면 바로 꺼냄
                    let dequeueValue = queue.dequeue()!.value
                    dequeueResult.append(dequeueValue)
                } else {
                    if queueSize - currentIndex > queueSize / 2 { // 절반보다 앞에 위치
                        for _ in 1...currentIndex {
                            queue.secondCase()
                        }
                        let dequeueValue = queue.dequeue()!.value
                        dequeueResult.append(dequeueValue)
                    } else { // 절반보다 뒤에 위치
                        for _ in 1...(queueSize - currentIndex) {
                            queue.thirdCase()
                        }
                        let dequeueValue = queue.dequeue()!.value
                        dequeueResult.append(dequeueValue)
                    }
                }

                break
            }
            currentNode = current.next
            currentIndex += 1
        }

        if dequeueResult == needToSelectedIndex {
            print(queue.result)
        }
    }

    final class Node<T: Equatable>: Equatable {
        static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
            lhs.value == rhs.value && lhs.next == rhs.next
        }

        let value: T
        var next: Node?
        var prior: Node?

        init(value: T) {
            self.value = value
            self.next = nil
            self.prior = nil
        }
    }

    final class LinkedList<T: Equatable> {
        var head: Node<T>?
        var tail: Node<T>?

        /// 마지막에 노드 추가 - O(1)
        func offer(value: T) {
            let node = Node(value: value)
            if let tailNode = tail {
                tailNode.next = node
                node.prior = tailNode
                tail = node
            } else { // 아무 node도 없는 경우
                head = node
                tail = node
            }
        }

        func insertFirst(value: T) {
            let node = Node(value: value)
            if let headNode = head {
                headNode.prior = node
                node.next = headNode
                head = node
            } else {
                head = node
                tail = node
            }
        }

        /// 첫 노드를 빼냄 - O(1)
        func poll() -> Node<T>? {
            let result = head
            if let next = head?.next {
                next.prior = nil
                head = next
            } else {
                head = nil
                tail = nil
            }

            return result
        }

        func removeLast() -> Node<T>? {
            let result = tail
            if let prior = tail?.prior {
                prior.next = nil
                tail = prior
            } else {
                head = nil
                tail = nil
            }

            return result
        }
    }

    final class Queue<T: Equatable> {
        var list = LinkedList<T>()
        var result = 0

        func enqueue(value: T) {
            list.offer(value: value)
        }

        /// dequeue하고 enqueue
        func secondCase() {
            if let dequeueNode = list.poll() {
                list.offer(value: dequeueNode.value)
                result += 1
            }
        }

        /// removeLast하고 insertFirst
        func thirdCase() {
            if let removeLastNode = list.removeLast() {
                list.insertFirst(value: removeLastNode.value)
                result += 1
            }
        }

        /// 첫번째 케이스
        func dequeue() -> Node<T>? {
            return list.poll()
        }
    }
}
