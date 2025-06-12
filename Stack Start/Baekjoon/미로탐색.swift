//
//  미로탐색.swift
//  DataStructures
//
//  Created by 양호준 on 6/12/25.
//

import Foundation

func findRouteAtMaze() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]
    let m = input[1]

    // 좌 상 우 하
    let dx = [-1, 0, 1, 0]
    let dy = [0, -1, 0, 1]

    struct Node {
        let x: Int
        let y: Int
        let distance: Int
    }

    var queue: [Node] = [Node(x: 0, y: 0, distance: 0)]
    var visited = Array(repeating: Array(repeating: 0, count: m), count: n)
    var maze = [[Int]]()
    var resultDistance: Int = Int.max

    for _ in 0..<n {
        let line = readLine()!.map { Int(String($0))! }
        maze.append(line)
    }
    print(maze)

    func isValid(nx: Int, ny: Int) -> Bool {
        return nx >= 0 && nx < n && ny >= 0 && ny < m && maze[nx][ny] == 1 ? true : false
    }

    func bfs() {
        while !queue.isEmpty {
            let currentNode = queue.removeFirst()
            let d = visited[currentNode.x][currentNode.y]
            print("while 반복문")
            print(currentNode)
            print(resultDistance)
            print("------------------")
            
            for i in 0..<dx.count {
                let nx = currentNode.x + dx[i]
                let ny = currentNode.y + dy[i]
                print("x 좌표\(nx) y 좌표\(ny)")
                
                if isValid(nx: nx, ny: ny) && visited[nx][ny] == 0 {
                    print("큐 추가")
                    visited[nx][ny] = d + 1
                    queue.append(Node(x: nx, y: ny, distance: currentNode.distance + 1))
                    print(queue)
                }
            }
        }
        print(visited[n - 1][m - 1])
    }

    visited[0][0] = 1
    bfs()

}
