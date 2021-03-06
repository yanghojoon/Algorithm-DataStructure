import Foundation

func solution(_ n:Int64) -> Int64 {
    let nToString = String(n)
    let sortedValue = nToString.sorted { first, second in
        first > second
    }
    let result = sortedValue.reduce("") { String($0) + String($1) }
    return Int64(result)!
}
