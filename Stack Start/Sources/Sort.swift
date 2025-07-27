//
//  Sort.swift
//  DataStructures
//
//  Created by 양호준 on 7/27/25.
//

import Foundation

// MARK: - 선택정렬(Selection Sort)
/// 처음부터 배열을 돌면서 현재 값보다 최소값이 존재하는지 확인하며 존재하는 경우 현재 값과 최소값을 바꿔줌 (시간복잡도 O(n))
func selectionSort<T: Comparable>(_ array: [T]) -> [T] {
    var sortedArray = array
    guard sortedArray.count > 1 else {
        return sortedArray
    }
    
    for i in 0..<sortedArray.count - 1 {
        var index = i
        for j in i + 1..<sortedArray.count {
            if sortedArray[j] < sortedArray[index] {
                sortedArray.swapAt(index, j)
            }
        }
    }
    return sortedArray
}
