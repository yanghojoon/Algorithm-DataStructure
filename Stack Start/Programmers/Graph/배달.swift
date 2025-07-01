//
//  배달.swift
//  DataStructures
//
//  Created by 양호준 on 6/30/25.
//

import Foundation

struct PriorityQueue1<T> {
    private var heap: [T] = []
    private let compare: (T, T) -> Bool

    init(compare: @escaping (T, T) -> Bool) {
        self.compare = compare
    }

    var isEmpty: Bool {
        return heap.isEmpty
    }

    mutating func enqueue(_ element: T) {
        heap.append(element)
        swim(heap.count - 1)
    }

    mutating func dequeue() -> T? {
        if heap.isEmpty { return nil }
        if heap.count == 1 { return heap.removeFirst() }
        heap.swapAt(0, heap.count - 1)
        let element = heap.removeLast()
        sink(0)
        return element
    }

    private mutating func swim(_ index: Int) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0 && compare(heap[child], heap[parent]) {
            heap.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }

    private mutating func sink(_ index: Int) {
        var parent = index
        while true {
            var child = 2 * parent + 1
            if child >= heap.count { break }
            if child + 1 < heap.count && compare(heap[child + 1], heap[child]) {
                child += 1
            }
            if !compare(heap[child], heap[parent]) { break }
            heap.swapAt(parent, child)
            parent = child
        }
    }
}

func dijkstra(graph: [Int: [(node: Int, weight: Int)]], startNode: Int) -> [Int: Int] {
    var distances: [Int: Int] = [:]
    for node in graph.keys {
        distances[node] = Int.max
    }
    distances[startNode] = 0
    
    var pq = PriorityQueue1<(distance: Int, node: Int)>(compare: { $0.distance < $1.distance })
    pq.enqueue((distance: 0, node: startNode))
    
    while let current = pq.dequeue() {
        let currentDistance = current.distance
        let currentNode = current.node
        
        if currentDistance > distances[currentNode]! {
            continue
        }
        
        if let neighbors = graph[currentNode] {
            for neighbor in neighbors {
                let distanceViaCurrent = currentDistance + neighbor.weight
                
                if distanceViaCurrent < distances[neighbor.node]! {
                    distances[neighbor.node] = distanceViaCurrent
                    pq.enqueue((distance: distanceViaCurrent, node: neighbor.node))
                }
            }
        }
    }
    
    return distances
}

func solution(_ N:Int, _ road:[[Int]], _ k:Int) -> Int {
    let graph = makeGraph(road: road, N: N)
    let dijkstraResult = dijkstra(graph: graph, startNode: 1)
    return dijkstraResult.values.filter { $0 <= k }.count
}

func makeGraph(road:[[Int]], N: Int) -> [Int: [(node: Int, weight: Int)]] {
    var graph: [Int: [(node: Int, weight: Int)]] = [:]
    for i in 1...N {
        graph[i] = []
    }
    
    for edge in road {
        let start = edge[0]
        let destination = edge[1]
        let weight = edge[2]
        
        graph[start]!.append((node: destination, weight: weight))
        graph[destination]!.append((node: start, weight: weight))
    }
    return graph
}
