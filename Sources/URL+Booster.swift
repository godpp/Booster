//
//  URL+Booster.swift
//  Booster
//
//  Created by ParkSungJoon on 19/02/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: Any]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {
            URLQueryItem(
                name: $0.key,
                value: "\($0.value)"
                    .addingPercentEncoding(
                        withAllowedCharacters: .urlQueryAllowed
            ))
        }
        return components?.url
    }
}
