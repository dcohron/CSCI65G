//
//  Utilities.swift
//

import Foundation

// MARK: Synchronization

/// The equivalent of @synchronized in ObjC
public func synchronized(object: AnyObject, closure: () -> Void) {
    objc_sync_enter(object)
    closure()
    objc_sync_exit(object)
}

// MARK: Byte Manipulation
func toByteArray<T>(var value: T) -> [UInt8] {
    return withUnsafePointer(&value) {
        Array(UnsafeBufferPointer(start: UnsafePointer<UInt8>($0), count: sizeof(T)))
    }
}

func fromByteArray<T>(value: [UInt8], _: T.Type) -> T {
    return value.withUnsafeBufferPointer {
        return UnsafePointer<T>($0.baseAddress).memory
    }
}


public enum Result<T> {
    case Success(() -> T)
    case Failure(NSError)
    
    public init(domain: String, code: Int, userInfo: [NSObject : AnyObject]?)
    {
        let e = NSError(domain: domain, code: code, userInfo: userInfo)
        self = .Failure(e)
    }
    
    public func then(nextOperation:T -> Result<T>) -> Result<T> {
        switch self {
        case let .Failure(error): return .Failure(error)
        case let .Success(something):   return nextOperation(something())
        }
    }
    
    public func isFailure() -> Bool {
        switch self {
        case let .Failure(error)    : return true
        case let .Success(something): return false
        }
    }
    
    public func unbox() -> Any {
        switch self {
        case let .Failure(error)    : return error
        case let .Success(something): return something
        }
    }
}

//MARK: FP Additions to Dictionary
extension Dictionary {
    
    func filter(includeElement: (Key,Value) -> Bool) -> [Key:Value] {
        var retVal = [ : ] as [Key:Value]
        for (k,v) in self {
            if includeElement(k,v) {
                retVal[k] = v
            }
        }
        return retVal
    }

    func map(transform: (Key,Value) -> (k:Key, v:Value)) -> [Key:Value] {
        var retVal = [ : ] as [Key:Value]
        for (k,v) in self {
            let t = transform(k,v)
            retVal[t.k] = t.v
        }
        return retVal
    }

    func reduce<T>(initial:T, combine: (T, Key, Value) -> T) -> T {
        var retVal = initial
        for (k,v) in self {
            retVal = combine(retVal,k,v)
        }
        return retVal
    }
    
}



