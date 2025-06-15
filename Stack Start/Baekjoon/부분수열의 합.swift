//
//  부분수열의 합.swift
//  DataStructures
//
//  Created by 양호준 on 6/15/25.
//

import Foundation

func combination() {
    // 만약 5개의 정수가 있다고 한다면 선택한다 / 안한다 2가지 경우의 수가 있어서 시간복잡도는 O(2^n)

    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]
    let s = input[1]

    let numbers = readLine()!.split(separator: " ").map { Int($0)! }

    func findSumCount(sum: Int, i: Int, depth: Int) -> Int {
        let indent = String(repeating: "  ", count: depth) // 깊이에 따라 들여쓰기
        
        print("\(indent)➡️ [진입] findSumCount(sum: \(sum), i: \(i))")
        
        var count = 0
        
        if sum == s {
            print("\(indent)🎯 [발견] 합계가 \(s)와 일치! (현재 경로의 count +1)")
            count += 1
        }
        
        // 현재 인덱스(i) 다음부터 루프를 돕니다.
        for index in i + 1..<n {
            let newSum = sum + numbers[index]
            
            print("\(indent)📞 [호출] for문(현재 index:\(index)), 하위 함수 findSumCount(sum: \(newSum), i: \(index))를 호출합니다.")
            
            // --- 재귀 호출 ---
            let resultFromChild = findSumCount(sum: newSum, i: index, depth: depth + 1)
            // ---------------
            
            count += resultFromChild
            print("\(indent)↩️ [복귀] for문(현재 index:\(index)), 하위 함수가 \(resultFromChild)을/를 반환했습니다. (현재 경로의 count: \(count))")
        }

        print("\(indent)⬅️ [종료] findSumCount(sum: \(sum), i: \(i))가 최종 count: \(count) 을/를 반환합니다.")
        return count
    }


    var count = 0
    for i in 0..<n {
        print("외부 for 문 인덱스: \(i)")
        print("----------")
        count += findSumCount(sum: numbers[i], i: i, depth: 0)
    }

    print(count)
}
