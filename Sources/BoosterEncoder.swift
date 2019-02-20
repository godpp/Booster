//
//  BoosterEncoder.swift
//  Booster
//
//  Created by ParkSungJoon on 19/02/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public enum EncodngType {
    case query
    case body
    case queryAndBody
}

extension EncodngType {
    func encode(request urlRequest: inout URLRequest, query: Parameters?, body: Parameters?) throws {
        do {
            switch self {
            case .query:
                guard let query = query else { return }
                urlRequest.url = urlRequest.url?.withQueries(query)
            case .body:
                guard let body = body else { return }
                try convertObjectToJSON(body, &urlRequest)
            case .queryAndBody:
                guard
                    let query = query,
                    let body = body else { return }
                urlRequest.url = urlRequest.url?.withQueries(query)
                try convertObjectToJSON(body, &urlRequest)
            }
        } catch BoosterError.convertToJSONFail {
            throw BoosterError.encodingFail
        }
    }
    
    private func convertObjectToJSON(_ body: Parameters, _ urlRequest: inout URLRequest) throws {
        do {
            let encodedBody = try JSONSerialization.data(
                withJSONObject: body,
                options: .prettyPrinted
            )
            urlRequest.httpBody = encodedBody
        } catch {
            throw BoosterError.convertToJSONFail
        }
    }
}
