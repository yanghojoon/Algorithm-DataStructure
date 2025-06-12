//
//  BFSandDFS.swift
//  DataStructures
//
//  Created by 양호준 on 6/12/25.
//

import Foundation

func BFSandDFS() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0] // Vertex 개수
    let m = input[1] // Edge 개수
    let v = input[2] // 첫 번째 Vertex
    var visited = [Bool](repeating: false, count: n + 1)
    var graph = [[Int]](repeating: [], count: n + 1)

    for _ in 0..<m {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let a = input[0], b = input[1]
        graph[a].append(b)
        graph[b].append(a)
    }

    graph = graph.map { $0.sorted() }

    func dfs(node: Int) {
        visited[node] = true
        print(node, terminator: " ")
        
        for nextNode in graph[node] {
            if !visited[nextNode] {
                dfs(node: nextNode)
            }
        }
        
    }

    func bfs(node: Int) {
        var queue = [node]
        var index = 0
        visited[node] = true
        while queue.count > index {
            let currentNode = queue[index]
            print(currentNode, terminator: " ")
            
            for nextNode in graph[currentNode] {
                if !visited[nextNode] {
                    visited[nextNode] = true
                    queue.append(nextNode)
                }
            }
            index += 1
        }
    }

    dfs(node: v)
    visited = [Bool](repeating: false, count: n + 1)
    print()
    bfs(node: v)
}
