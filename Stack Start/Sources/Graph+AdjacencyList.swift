//
//  Graph+AdjacencyList.swift
//  DataStructures
//
//  Created by 양호준 on 6/10/25.
//

import Foundation

protocol Graphable {
    associatedtype Element: Hashable
    var description: CustomStringConvertible { get }

    func createVertex(data: Element) -> Vertex<Element>
    func add(_ type: EdgeType, from source: Vertex<Element>, to destiantion: Vertex<Element>, weight: Double?)
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
    func edges(from source: Vertex<Element>) -> [Edge<Element>]?
}

struct Vertex<T: Hashable>: Hashable {
    let data: T
}

extension Vertex: CustomStringConvertible {
    var description: String {
        return "\(data)"
    }
}

enum EdgeType {
    case directed, undirected
}

struct Edge<T: Hashable>: Hashable {
    var source: Vertex<T>
    var destination: Vertex<T>
    let weight: Double?
}

class AdjacencyList<T: Hashable> {
    var adjDic: [Vertex<T>: [Edge<T>]] = [:]
    init() { }

    private func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjDic[source]?.append(edge)
    }

    private func addUndirectedEdge(vertices: (Vertex<T>, Vertex<T>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
}

extension AdjacencyList: Graphable {
    typealias Element = T

    var description: any CustomStringConvertible {
        var result = ""
        for (vertex, edges) in adjDic {
          var edgeString = ""
          for (index, edge) in edges.enumerated() {
            if index != edges.count - 1 {
              edgeString.append("\(edge.destination), ")
            } else {
              edgeString.append("\(edge.destination)")
            }
          }
          result.append("\(vertex) ---> [ \(edgeString) ] \n ")
        }
        return result

    }
    
    func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(data: data)

        if adjDic[vertex] == nil {
            adjDic[vertex] = []
        }

        return vertex
    }

    func add(_ type: EdgeType, from source: Vertex<T>, to destiantion: Vertex<T>, weight: Double?) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destiantion, weight: weight)
        case .undirected:
            addUndirectedEdge(vertices: (source, destiantion), weight: weight)
        }
    }

    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        guard let edges = adjDic[source] else {
            return nil
        }

        for edge in edges {
            if edge.destination == destination {
                return edge.weight
            }
        }

        return nil
    }

    func edges(from source: Vertex<T>) -> [Edge<T>]? {
        return adjDic[source]
    }
}
