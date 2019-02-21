//
//  BoosterService.swift
//  Booster
//
//  Created by ParkSungJoon on 19/02/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

//MARK: - Base Protocol Service

public typealias HTTPHeader = [HTTPHeaderField: String]

/// This Protocol is basic implementation for EndPoint
public protocol BoosterService {
    var baseURL: URL { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    var task: HTTPTask { get }
    var header: HTTPHeader? { get }
}

/// Four types HTTPMethod (GET, POST, PUT, DELETE)
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

/// Two types HTTPTask
public enum HTTPTask {
    /// request is for url calls only.
    case request
    /// requestWith is for the things that need encoding.
    /// - url: URL requiring encoding
    /// - body: Body requiring encoding
    /// - encoding: URL or Body or Both
    case requestWith(url: Parameters?, body: Parameters?, encoding: EncodngType)
}

/// This is default Header for convenient to use
public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case contentDisposition = "Content-Disposition"
    case naverClientID = "X-Naver-Client-Id"
    case naverClientSecret = "X-Naver-Client-Secret"
}

/// This is default Content Type for convenient to use
public enum ContentType: String {
    case json = "application/json"
}
