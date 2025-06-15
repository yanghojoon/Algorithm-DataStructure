//
//  타겟넘버.swift
//  DataStructures
//
//  Created by 양호준 on 6/15/25.
//

import Foundation

func solution(_ numbers:[Int], _ target:Int) -> Int {
    var result = 0
    var convertedNumbers = numbers
    
    numbers.forEach {
        convertedNumbers.append(-$0)
    }
    
    for i in 0..<convertedNumbers.count {
        result += countTarget(
            sum: convertedNumbers[i],
            index: i,
            target: target,
            numbers: convertedNumbers
        )
    }
    
    return result
}

func countTarget(sum: Int, index: Int, target: Int, numbers: [Int]) -> Int {
    var count = 0
    
    if sum == target {
        count += 1
    }
    
    for i in index + 1..<numbers.count {
        let newSum = sum + numbers[i]
        count += countTarget(
            sum: newSum,
            index: i,
            target: target,
            numbers: numbers
        )
    }
    
    return count
}
