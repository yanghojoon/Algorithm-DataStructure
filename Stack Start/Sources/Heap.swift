import Foundation

//struct Heap<Element: Equatable> {
//    fileprivate var elements = [Element]()
//    let areSorted: (Element, Element) -> Bool
//    
//    init(_ element: [Element], areSorted: @escaping (Element, Element) -> Bool) {
//        self.areSorted = areSorted
//        self.elements = element
//        
//        guard !element.isEmpty else { return }
//        
//        for index in stride(from: element.count / 2 - 1, through: 0, by: -1) { // from은 트리의 계층(단계)을 의미.
//            siftDown(from: index)
//        }
//    }
//    
//    var isEmpty: Bool {
//        return elements.isEmpty
//    }
//    
//    var count: Int {
//        return elements.count
//    }
//    
//    func peek() -> Element? {
//        return elements.first
//    }
//    
//    func getChildIndicies(ofParentAt parentIndex: Int) -> (left: Int, right: Int) {
//        let leftIndex = (2 * parentIndex) + 1 // binary tree는 항상 2개의 child만 가지기 때문에 이렇게 index를 구함.
//        
//        return (leftIndex, leftIndex + 1)
//    }
//    
//    func getParentIndex(ofChildAt index: Int) -> Int {
//        return (index - 1) / 2
//    }
//    
//    mutating func removeRoot() -> Element? {
//        guard !isEmpty else {
//            return nil
//        }
//        
//        elements.swapAt(0, count - 1) // 처음과 마지막을 바꾸고
//        let originalRoot = elements.removeLast() // 마지막거를 빼면 처음거를 빼는 것과 같다.  
//        siftDown(from: 0)
//        
//        return originalRoot
//    }
//    
//    mutating func siftDown(from index: Int) {
//        var parentIndex = index
//        while true {
//            let (leftIndex, rightIndex) = getChildIndicies(ofParentAt: parentIndex)
//            var optionalParentSwapIndex: Int?
//            
//            if leftIndex < count && areSorted(elements[leftIndex], elements[parentIndex]) { // 일단 왼쪽 index가 count보다 크다면 이미 leftchild는 없는 상황.
//                optionalParentSwapIndex = leftIndex // 왼쪽 child로 내려감.
//            }
//            if rightIndex < count && areSorted(elements[rightIndex], elements[optionalParentSwapIndex ?? parentIndex]) {
//                optionalParentSwapIndex = rightIndex
//            }
//            
//            guard let parentSwapIndex = optionalParentSwapIndex else { return }
//            
//            elements.swapAt(parentIndex, parentSwapIndex)
//            parentIndex = parentSwapIndex
//        }
//    }
//    
//}

struct Heap<T: Comparable> {
    private var elements: [T] = []
    private let sortFunction: (T, T) -> Bool
    
    var isEmpty: Bool {
        return self.elements.count == 1
    }
    var peek: T? {
        if self.isEmpty { return nil }
        return self.elements.last!
    }
    var count: Int {
        return self.elements.count - 1
    }
    
    init(elements: [T] = [], sortFunction: @escaping (T, T) -> Bool) {
        if !elements.isEmpty {
            self.elements = [elements.first!] + elements
        } else {
            self.elements = elements
        }
        self.sortFunction = sortFunction
        if elements.count > 1 {
            self.buildHeap()
        }
    }
    
    func leftChild(of index: Int) -> Int {
        return index * 2
    }
    func rightChild(of index: Int) -> Int {
        return index * 2 + 1
    }
    func parent(of index: Int) -> Int {
        return (index) / 2
    }
    mutating func add(element: T) {
        self.elements.append(element)
    }
    mutating func diveDown(from index: Int) {
        var higherPriority = index
        let leftIndex = self.leftChild(of: index)
        let rightIndex = self.rightChild(of: index)
        
        if leftIndex < self.elements.endIndex && self.sortFunction(self.elements[leftIndex], self.elements[higherPriority]) {
            higherPriority = leftIndex
        }
        if rightIndex < self.elements.endIndex && self.sortFunction(self.elements[rightIndex], self.elements[higherPriority]) {
            higherPriority = rightIndex
        }
        if higherPriority != index {
            self.elements.swapAt(higherPriority, index)
            self.diveDown(from: higherPriority)
        }
    }
    mutating func swimUp(from index: Int) {
        var index = index
        while index != 1 && self.sortFunction(self.elements[index], self.elements[self.parent(of: index)]) {
            self.elements.swapAt(index, self.parent(of: index))
            index = self.parent(of: index)
        }
    }
    mutating func buildHeap() {
        for index in (1...(self.elements.count / 2)).reversed() {
            self.diveDown(from: index)
        }
    }
    mutating func insert(node: T) {
        if self.elements.isEmpty {
            self.elements.append(node)
        }
        self.elements.append(node)
        self.swimUp(from: self.elements.endIndex - 1)
    }
    mutating func remove() -> T? {
        if self.isEmpty { return nil }
        self.elements.swapAt(1, elements.endIndex - 1)
        let deleted = elements.removeLast()
        self.diveDown(from: 1)
        
        return deleted
    }
}
struct PriorityQueue<T: Comparable> {
    var heap: Heap<T>
    
    init(_ elements: [T] = [], _ sort: @escaping (T, T) -> Bool) {
        heap = Heap(elements: elements, sortFunction: sort)
    }
    
    var count : Int {
        return heap.count
    }
    var isEmpty : Bool {
        return heap.isEmpty
    }
    
    func top () -> T? {
        return heap.peek
    }
    mutating func clear () {
        while !heap.isEmpty {
            _ = heap.remove()
        }
    }
    mutating func pop() -> T? {
        return heap.remove()
    }
    mutating func push(_ element: T) {
        heap.insert(node: element)
    }
}
