//
//  QValue.swift
//  SwiftQValue
//
//  Created by Yuma decaux on 14/1/2025.
//


public enum QValue: Hashable, Identifiable {
    /** Quantum value which collapses to a working type
     for codable Json structs
     */
    case int(Int)
    case string(String)
    case float(Float)
    case bool(Bool)
    
    public var id: Self {
        return self
    }
    
    public func type() -> String {
        switch self {
        case .string(_): return "String"
                     case .int(_): return
                     "int"
                     case .float(_): return
                     "float"
        case .bool(_): return "bool"
        }
    }
}
extension QValue:Codable {

    public init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(intValue)
            print("found int \(self)")
            return
        }
        if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(stringValue)
            print("found string \(self)")
            return
        }
        if let floatValue = try? decoder.singleValueContainer().decode(Float.self) {
            self = .float(floatValue)
            print("found float \(self)")
            return
        }
        if let boolValue = try? decoder.singleValueContainer().decode(Bool.self) {
            self = .bool(boolValue)
            return
        }
        
        // This is a NULL value so keep as empty string
        // instead of throwing error
        // The removenullrecord flag in the request
        // will omit these key/value pairs
        self = .string("")
    }

    public init(value: String) {
        if let int = Int(value) {
            self = .int(int)
            return
        }
        if let float = Float(value) {
            self = .float(float)
            return
        }
        if let bool = Bool(value) {
            self = .bool(bool)
            return
        }
            self = .string(value)
    }

    
    public func encode(to encoder: Encoder) throws {
        var singleContainer = encoder.singleValueContainer()
        
        switch self {
        case .int(let int):
            try singleContainer.encode(int)
        case .string(let string):
            try singleContainer.encode(string)
        case .float(let float):
            try singleContainer.encode(float)
        case .bool(let bool):
            try singleContainer.encode(bool)
        }
    }

    public var value:Any {
        switch self {
        case .string(let str):
            return str
        case .float(let ft):
            return ft
        case .bool(let b):
            return b
        case .int(let n):
            return n
        }
    }
    
    
    public var string:String {
        return self.value as! String
    }
    
    public var int:Int {
        return self.value as! Int
    }
    
    public var float:Float {
        return self.value as! Float
    }
    
    public var bool:Bool {
        return self.value as! Bool
    }
    
}

