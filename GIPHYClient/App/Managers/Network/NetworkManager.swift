//
//  NetworkManager.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/21/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import Foundation

enum GIPHYAPIService {
    case trending(_ limit: Int)

    enum RESTMehtod: String {
        case get = "GET"
    }

    enum RESTParameterType {
        case url
        case body
    }
}

extension GIPHYAPIService {

    static var baseURL = URL(string: "https://api.giphy.com/v1/")!

    var endpoint: String {
        switch self {
        case .trending(_):
            return "gifs/trending"
        }
    }

    var url: URL {
        var newURL = GIPHYAPIService.baseURL
        newURL.appendPathComponent(endpoint)
        return newURL
    }

    var method: RESTMehtod {
        switch self {
        case .trending:
            return .get
        }
    }

    var parameterEncoding: RESTParameterType {
        switch self {
        case .trending:
            return .url
        }
    }

    var parameters: [String: Any] {
        switch self {
        case let .trending(limit):
            return ["api_key": "QnoLFSxKa5kEdVyuaj3Hk6KuFKTnMYOn",
                    "limit": limit]
        }
    }

    func sendRequest(completion: @escaping (Data) -> ()) {
        let urlComponents = NSURLComponents(string: url.absoluteString)!
        let queryItems = parameters.compactMap { (object) -> URLQueryItem in
            return URLQueryItem(name: object.key, value: "\(object.value)")
        }

        urlComponents.queryItems = queryItems

        guard
            let finalURL = urlComponents.url
            else {
                assertionFailure("Failed Formatting URL, \(urlComponents)")
                return
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        let session = URLSession.shared

        session.dataTask(with: request) { data, response, error in
            guard
                let data = data
                else {
                    return
            }

            completion(data)
            }.resume()
    }

}
