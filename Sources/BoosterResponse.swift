//
//  BoosterResponse.swift
//  Booster
//
//  Created by ParkSungJoon on 19/02/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

public enum ResponseType {
    case success
    case clientError
    case serverError
    case failure
}

public struct BoostResponse {
    func result(_ response: HTTPURLResponse) -> ResponseType {
        switch response.statusCode {
        case 200..<300: return .success
        case 400..<500: return .clientError
        case 500..<600: return .serverError
        default: return .failure
        }
    }
}
