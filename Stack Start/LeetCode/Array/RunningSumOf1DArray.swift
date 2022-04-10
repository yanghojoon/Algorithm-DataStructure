import Foundation

class SolutionArrayE {
    func runningSum(_ nums: [Int]) -> [Int] {
        var newArray: [Int] = []
        var element = 0
        nums.forEach { num in
            element += num
            newArray.append(element)
        }
        
        return newArray
    }
}
