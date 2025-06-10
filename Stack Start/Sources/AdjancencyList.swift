import Foundation


//struct AdjacencyList<Element: Hashable>: Graph { // 이전 파일에 생성한 Graph 프로토콜 채택
//    
//    typealias Edge = GraphEdge<Element>
//    typealias Vertex = Edge.Vertex
//    
//    private var adjacencies: [Vertex: [Edge]] = [:]
//    
//    var vertices: [Vertex] {
//        return Array(adjacencies.keys)
//    }
//    
//    @discardableResult mutating func addVertex(_ element: Element) -> Vertex {
//        let vertex = Vertex(index: adjacencies.count, element: element)
//        adjacencies[vertex] = [] // 새로 만들어진 Vertex의 경우 연결된 Edge가 없기 때문에 빈 배열 할당
//        
//        return vertex
//    }
//    
//    mutating func add(_ edge: Edge) { // bidirectional
//        adjacencies[edge.source]?.append(edge)
//        
//        let reversedEdge = Edge(
//            source: edge.destination,
//            destination: edge.source,
//            weight: edge.weight
//        )
//        adjacencies[edge.destination]!.append(reversedEdge)
//    }
//    
//    func getEdges(from source: Vertex) -> [Edge] {
//        return adjacencies[source] ?? []
//    }
//
//}
//
//extension AdjacencyList: CustomStringConvertible {
//  var description: String {
//    return
//      adjacencies.mapValues { edges in
//        edges
//          .sorted { $0.destination.index < $1.destination.index }
//          .map { "\($0.destination.element) (\($0.weight))" }
//      }
//      .sorted { $0.key.index < $1.key.index }
//      .map {
//        let source = "\($0.key.index): \($0.key.element)"
//
//        guard !$0.value.isEmpty else {
//          return source
//        }
//
//        let sourceWithArrow = "\(source) -> "
//        return """
//          \(sourceWithArrow)\($0.value.joined(separator: "\n"
//            + String(repeating: " ", count: sourceWithArrow.count)
//          ))
//          """
//      }
//      .joined(separator: "\n\n")
//  }
//}
