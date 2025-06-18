//
//  단어변환.swift
//  DataStructures
//
//  Created by 양호준 on 6/18/25.
//

import Foundation

func solution(_ begin: String, _ target: String, _ words: [String]) -> Int {
    guard words.contains(target) else { return 0 }

    var queue: [(String, Int)] = [(begin, 0)] // (단어, 변환 횟수)
    var visited = Array(repeating: false, count: words.count)

    while !queue.isEmpty {
        let (current, depth) = queue.removeFirst()

        if current == target {
            return depth
        }

        for (i, word) in words.enumerated() {
            if !visited[i], isDifferentOneCharacter(current, and: word) {
                visited[i] = true
                queue.append((word, depth + 1))
            }
        }
    }

    return 0
}

func isDifferentOneCharacter(_ word1: String, and word2: String) -> Bool {
    zip(word1, word2).filter { $0 != $1 }.count == 1
}
