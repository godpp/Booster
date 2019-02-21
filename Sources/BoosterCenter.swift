//
//  BoosterCenter.swift
//  Booster
//
//  Created by ParkSungJoon on 19/02/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import Foundation

public typealias DataCompletion = (_ data: Data?, _ error: BoosterError?) -> Void

public typealias JSONCompletion = (_ rawJSON: String?, _ error: BoosterError?) -> Void

public class BoosterCenter<Service: BoosterService> {
    
    public init() {}
    
    @discardableResult
    public func request(_ service: Service, completion: @escaping DataCompletion) -> URLSessionDataTask {
        var dataTask = URLSessionDataTask()
        do {
            let urlRequest = try makeURLRequest(from: service)
            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, _) in
                guard let data = data else {
                    return completion(nil, BoosterError.noData)
                }
                guard let response = response as? HTTPURLResponse else {
                    return completion(data, BoosterError.noResponse)
                }
                let statusCode = response.statusCode
                switch BoostResponse().result(response) {
                case .success:
                    completion(data, nil)
                case .failure:
                    completion(data, BoosterError.networkFail)
                case .clientError:
                    completion(data, BoosterError.clientError(statusCode: statusCode))
                case .serverError:
                    completion(data, BoosterError.serverError(statusCode: statusCode))
                }
            }
            dataTask.resume()
        } catch {
            completion(nil, BoosterError.makeURLRequestFail)
        }
        return dataTask
    }
    
    /// requestDownload is download task to json file.
    public func requestDownload(_ service: Service, completion: @escaping JSONCompletion) {
        do {
            let urlRequest = try makeURLRequest(from: service)
            let task = URLSession.shared.downloadTask(with: urlRequest) { (localURL, response, _) in
                guard let localURL = localURL else {
                    return completion(nil, BoosterError.invalidURL)
                }
                do {
                    let rawJSON = try String(contentsOf: localURL)
                    guard let response = response as? HTTPURLResponse else {
                        return completion(nil, BoosterError.noResponse)
                    }
                    let statusCode = response.statusCode
                    switch BoostResponse().result(response) {
                    case .success:
                        completion(rawJSON, nil)
                    case .failure:
                        completion(rawJSON, BoosterError.networkFail)
                    case .clientError:
                        completion(rawJSON, BoosterError.clientError(statusCode: statusCode))
                    case .serverError:
                        completion(rawJSON, BoosterError.serverError(statusCode: statusCode))
                    }
                } catch {
                    completion(nil, BoosterError.decodingFail)
                }
            }
            task.resume()
        } catch {
            completion(nil, BoosterError.makeURLRequestFail)
        }
    }
    
    private func makeURLRequest(from service: Service) throws -> URLRequest {
        var fullURL = service.baseURL
        if let path = service.path {
            fullURL = fullURL.appendingPathComponent(path)
        }
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = service.method.rawValue
        switch service.task {
        case .request:
            setHeaderField(&urlRequest, header: service.header)
        case .requestWith(let query, let body, let encoder):
            do {
                try encoder.encode(request: &urlRequest, query: query, body: body)
                setHeaderField(&urlRequest, header: service.header)
            } catch {
                throw error
            }
        }
        return urlRequest
    }
    
    private func setHeaderField(_ urlRequest: inout URLRequest, header: HTTPHeader?) {
        urlRequest.setValue(
            ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue
        )
        urlRequest.setValue(
            ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue
        )
        guard let header = header else { return }
        for (key, value) in header {
            urlRequest.setValue(value, forHTTPHeaderField: key.rawValue)
        }
    }
}
