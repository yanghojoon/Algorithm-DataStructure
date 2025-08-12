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

// MARK: Merge Sort
/// 시간 복잡도 : nLogn -> logn의 경우 절반으로 계속 쪼개는 과정에서 발생 / 병합과정에서 정렬을 하면서 다시 합치는 과정이 n
func mergeSort<T: Comparable>(list: [T]) -> [T] {
    guard list.count > 1 else {
        return list
    }

    let leftList = Array(list[0..<list.count / 2])
    let rightList = Array(list[list.count / 2..<list.count])

    return merge(left: mergeSort(list: leftList), right: mergeSort(list: rightList)) // 재귀로 돌면서 계속 쪼갤 수 있도록 함 (가장 작은 단위까지 쪼갠 후 정렬하며 병합됨)
}

func merge<T: Comparable>(left: [T], right: [T]) -> [T] {
    var mergedList = [T]()
    var left = left
    var right = right

    while left.count > 0 && right.count > 0 {
        if left.first! < right.first! { // 비교해서 작은 값을 넣는 과정
            mergedList.append(left.removeFirst())
        } else {
            mergedList.append(right.removeFirst())
        }
    }

    return mergedList + left + right
}

// MARK: Quick Sort // 요소가 다 겹칠 때 요소가 하나로 나오게 됨
func quickSort<T: Comparable>(_ array: [T]) -> [T] {
    guard let first = array.first, array.count > 1 else { return array }

    let pivot = first // 첫 번째 값부터 기준점을 잡고
    let left = array.filter { $0 < pivot } // 그거보다 작으면 왼쪽에 모아둠 (이때 정렬을 하진 않음 - 배열 순서대로)
    let right = array.filter { $0 > pivot } // 그거보다 크면 오른쪽에 모아둠

    return quickSort(left) + [pivot] + quickSort(right) // 재귀로 쪼갤 값이 있을 때까지 쪼개며 첫 번째 값 기준으로 정렬을 해나감
}
