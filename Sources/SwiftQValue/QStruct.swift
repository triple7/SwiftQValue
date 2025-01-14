//
//  QStruct.swift
//  SwiftQValue
//
//  Created by Yuma decaux on 14/1/2025.
//


public enum QObject:Codable {
    case qValue(QValue)
    case qArr([QValue])
    case qDict([[String: QValue]])
    case qDictSingle([String: QValue])
    
    public init(values: Any) {
        switch values {
        case let qValue as QValue:
            self = .qValue(qValue)
        case let qArr as [QValue]:
            self = .qArr(qArr)
        case let qDict as [[String: QValue]]:
            self = .qDict(qDict)
        case let qDictSingle as [String: QValue]:
            self = .qDictSingle(qDictSingle)
        default:
            fatalError("Incompatible data structure")
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let qValue = try? container.decode(QValue.self) {
            self = .qValue(qValue)
        }
        if let qArr = try? container.decode([QValue].self) {
            self = .qArr(qArr)
        }
        if let qDict = try? container.decode([[String:QValue]].self) {
            self = .qDict(qDict)
        }
        if let qDictSingle = try? container.decode([String:QValue].self) {
            self = .qDictSingle(qDictSingle)
        }
            fatalError("Failed to decode FilterValues")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .qValue(let qValue):
            try container.encode(qValue)
        case .qArr(let qArr):
            try container.encode(qArr)
        case .qDict(let qDict):
            try container.encode(qDict)
        case .qDictSingle(let qDictSingle):
            try container.encode(qDictSingle)
        }
    }

}