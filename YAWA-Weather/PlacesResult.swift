//
//  PlacesResult.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/24/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

public enum PlacesResult<Value, DataError> {
    
    case Success(Value)
    case Failure(DataError)
    
    public var value: Value?
    {
        switch self {
        case .Success(let value):
            return value
        case .Failure:
            return nil
        }
    }
    
    public var error: DataError?
    {
        switch self {
        case .Success:
            return nil
        case .Failure(let err):
            return err
        }
    }
}
