//
//  QObject.swift
//  SwiftQValue
//
//  Created by Yuma decaux on 14/1/2025.
//


public enum QObject:Codable {
    case qValue(QValue)
    case qArr([QValue])
    case q2DArr([[QValue]])
    case qDict([[String: QValue]])
    case qDictSingle([String: QValue])
    
    public init(values: Any) {
        switch values {
        case let qValue as QValue:
            self = .qValue(qValue)
        case let qArr as [QValue]:
            self = .qArr(qArr)
        case let q2dArr as [[QValue]]:
            self = .q2DArr(q2dArr)
        case let qDict as [[String: QValue]]:
            self = .qDict(qDict)
        case let qDictSingle as [String: QValue]:
            self = .qDictSingle(qDictSingle)
        default:
            fatalError("Incompatible data structure")
        }
    }

    public init(from decoder: Decoder) throws {
        print("init from decoder")
            
        let container = try decoder.singleValueContainer()
        if let qValue = try? container.decode(QValue.self) {
            self = .qValue(qValue)
            return
        }
        if let qArr = try? container.decode([QValue].self) {
            self = .qArr(qArr)
            return
        }
        if let q2dArr = try? container.decode([[QValue]].self) {
            self = .q2DArr(q2dArr)
            return
        }
        if let qDict = try? container.decode([[String:QValue]].self) {
            self = .qDict(qDict)
            return
        }
        if let qDictSingle = try? container.decode([String:QValue].self) {
            self = .qDictSingle(qDictSingle)
            return
        }
            fatalError("Failed to decode QObject")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .qValue(let qValue):
            try container.encode(qValue)
        case .qArr(let qArr):
            try container.encode(qArr)
        case .q2DArr(let q2dArr):
            try container.encode(q2dArr)
        case .qDict(let qDict):
            try container.encode(qDict)
        case .qDictSingle(let qDictSingle):
            try container.encode(qDictSingle)
        }
    }

}
