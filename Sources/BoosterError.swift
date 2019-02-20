//
//  BoosterError.swift
//  Booster
//
//  Created by ParkSungJoon on 19/02/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

public enum BoosterError: LocalizedError {
    case invalidURL
    case convertToJSONFail
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case makeURLRequestFail
    case noData
    case noResponse
    case networkFail
    case decodingFail
    case encodingFail
    
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL : 유효하지 않은 URL입니다.", comment: "")
        case .convertToJSONFail:
            return NSLocalizedString("Convert Fail : JSON 형식으로 변환할 수 없습니다.", comment: "")
        case .clientError(let statusCode):
            return NSLocalizedString("Client Error : \(statusCode)", comment: "")
        case .serverError(let statusCode):
            return NSLocalizedString("Server Error : \(statusCode)", comment: "")
        case .makeURLRequestFail:
            return NSLocalizedString("URL Request Fail : URLRequest를 생성하지 못했습니다.", comment: "")
        case .noData:
            return NSLocalizedString("No Data : 서버로부터 받아올 데이터가 없습니다.", comment: "")
        case .noResponse:
            return NSLocalizedString("No Response : 서버로부터 응답이 없습니다.", comment: "")
        case .networkFail:
            return NSLocalizedString("Network Fail : 통신에 실패하였습니다.", comment: "")
        case .decodingFail:
            return NSLocalizedString("Decode Fail : JSON Decoding이 실패하였습니다.", comment: "")
        case .encodingFail:
            return NSLocalizedString("Encode Fail : JSON Encoding이 실패하였습니다.", comment: "")
        }
    }
}
