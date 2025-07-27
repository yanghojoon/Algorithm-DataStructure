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
        for j in i + 1..<sortedArray.count { // 현재 인덱스 다음 값들을 확인
            if sortedArray[j] < sortedArray[i] {
                sortedArray.swapAt(i, j)
            }
        }
    }
    return sortedArray
}

// MARK: - 삽입정렬(Insertion Sort)


// MARK: - 버블정렬(Bubble Sort)
/// 다음 요소와 비교하면서 다음 요소가 더 작으면 swap
/// 가장 마지막 요소가 가장 큰 값으로 계속 정렬이 됨
func bubbleSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    var sortedArray = array
    
    for _ in 0..<sortedArray.count {
        var isSwap = false // 변경한 값이 있는지 확인하는 플래그
        
        for j in 0..<sortedArray.count - 1 {
            if sortedArray[j] > sortedArray[j + 1] {
                sortedArray.swapAt(j, j + 1)
                isSwap = true
            }
        }
        
        if isSwap == false {
            break
        }
    }
    
    return sortedArray
}
