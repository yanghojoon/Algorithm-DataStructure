//
//  네트워크.swift
//  DataStructures
//
//  Created by 양호준 on 6/15/25.
//

import Foundation

func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    var visited = [Bool](repeating: false, count: n)
    var result = 0
    
    func dfs(computer: Int) {
        visited[computer] = true
        for i in 0..<n {
            if computers[computer][i] == 1 && !visited[i] { // 연결된 Vertex 쭉 찾음
                dfs(computer: i)
            }
        }
    }
    
    for i in 0..<n {
        if !visited[i] {
            result += 1
            dfs(computer: i)
        }
    }
    
    return result
}
