//
//  BoosterResult.swift
//  Booster
//
//  Created by ParkSungJoon on 19/02/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(BoosterError)
    
    var value: Value? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }
    
    var error: BoosterError? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}
