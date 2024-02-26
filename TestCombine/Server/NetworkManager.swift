//
//  NetworkManager.swift
//  TestCombine
//
//  Created by Fermin Esquisabel Garcia on 26/2/24.
//

import Foundation
import Combine

enum NetworkError: String, Error {
    case genericError = "Generic error"
    case notFound = "Not found"
    case unauthorized = "Unautorhized user"
}

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
        
    let baseUrl = "https://aloha2.geoactio.com/index.php/api/"
    
    var storage = Set<AnyCancellable>()
    
    lazy var defaultSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        config.timeoutIntervalForRequest = 10.0
        config.timeoutIntervalForResource = 15.0
        return URLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }()
    
    private override init() { }
    
    func get<T: Decodable>(method: String) -> AnyPublisher<T, Error> {
        let url = baseUrl + method
        
        print("(GET) -----> " + url)
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("Basic b2NyOm9vSW9v", forHTTPHeaderField: "Authorization")
        
        return defaultSession.dataTaskPublisher(for: urlRequest)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
