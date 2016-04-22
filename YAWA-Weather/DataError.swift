//
//  DataError.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/22/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

public enum DataError {
    
    case FormatError(String)
    case ServerError(String)
    case None
    
    public var errorCondition: String? {
        switch self {
        case .FormatError(let value):
            return value
        case .ServerError(let value):
            return value
        case .None:
            return nil
        }
    }
}