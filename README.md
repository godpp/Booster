# 🚀 Booster

Author : [godpp](https://github.com/godpp)

## Intro

* Booster was developed during NAVER Connect Foundation's the BoostCamp 3rd iOS Process.
* Booster is an Simple HTTP Networking Library written in Swift.
* Booster was created using only the Apple Frameworks.

## Installation

### Cocoapods

```swift
pod 'Booster'
```

### Usage

First, you should define an API Endpoint of type enum.
```swift
enum BoosterAPI {
    case fetchLiquidOxygen(type: String, quantity: Int)
}
```

Second, you should adopt the BoosterService protocol for an actual implementation of those requirements.
```swift
extension BoosterAPI: BoosterService {
    
    var baseURL: URL {
        guard let url = URL(string: BaseURL.BoosterAPI) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    var path: String? {
        switch self {
        case .fetchLiquidOxygen:
            return "/fuel"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchLiquidOxygen:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .fetchLiquidOxygen(let type, let quantity):
            return ["type": type, "quantity": quantity]
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .fetchLiquidOxygen:
            return .requestWith(url: parameters, body: nil, encoding: .query)
        }
    }
    
    var header: HTTPHeader? {
        return nil
    }
}
```

Third, you should implement BoosterManager(has Router) and define static method.
```swift
final class BoosterManager {
    static func fetchLiquidOxygen(
        type: String,
        quantity: Int,
        completion: @escaping (Result<BoosterModel>) -> Void
    ) -> URLSessionDataTask {
        return BoosterCenter<BoosterAPI>().request(.fetchLiquidOxygen(
            type: type,
            quantity: quantity
        )) { (data, error) in
            guard error == nil else {
                return completion(Result.failure(error!))
            }
            guard let responseData = data else { return }
            do {
                let resultData = try JSONDecoder().decode(BoosterModel.self, from: responseData)
                completion(Result.success(resultData))
            } catch {
                completion(Result.failure(BoosterError.decodingFail))
            }
        }
    }
}
```

Finally, you can access an API like this:
```swift
let dataTask = BoosterManager.fetchLiquidOxygen(type: type, quantity: quantity) { result in
    switch result {
    case .success(let resultData):
        // do something with response data
    case .failure(let error):
        print(error.localizedDescription)
    }
}
```
