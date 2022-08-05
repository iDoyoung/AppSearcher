//
//  Endpoint.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/04.
//

import Foundation

enum HttpMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum RequestGenerationError: Error {
    case components
}

protocol Requestable {
    associatedtype Response
    
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HttpMethodType { get }
    var headerParameters: [String: String] { get }
    var queryParameters: [String: String] { get }
    var encodableBodyParameters: Encodable? { get }
    var bodyParameters: [String: Any] { get }
    
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

struct Endpoint<T>: Requestable {
    typealias Response = T
    
    var path: String
    var isFullPath: Bool
    var method: HttpMethodType
    var headerParameters: [String : String]
    var queryParameters: [String : String]
    var encodableBodyParameters: Encodable?
    var bodyParameters: [String : Any]
    
    init(path: String,
         isFullPath: Bool = false,
         method: HttpMethodType = .get,
         headerParameters: [String: String] = [:],
         queryParameters: [String: String] = [:],
         encodableBodyParameters: Encodable? = nil,
         bodyParameters: [String: Any] = [:]) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.encodableBodyParameters = encodableBodyParameters
        self.bodyParameters = bodyParameters
    }
}

extension Requestable {
    func url(with configuration: NetworkConfigurable) throws -> URL {
        let baseURL = configuration.baseURL.absoluteString.last != "/" ? configuration.baseURL.absoluteString + "/" : configuration.baseURL.absoluteString
        let endpoint = isFullPath ? path : baseURL.appending(path)
        guard var urlComponents = URLComponents(string: endpoint) else {
            throw RequestGenerationError.components
        }
        var urlQueryItems = [URLQueryItem]()
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        configuration.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = urlQueryItems.isEmpty ? nil : urlQueryItems
        guard let url = urlComponents.url else {
            throw RequestGenerationError.components
        }
        return url
    }
    func urlRequest(with configuration: NetworkConfigurable) throws -> URLRequest {
        let url = try url(with: configuration)
        var urlRequest = URLRequest(url: url)
        var allHeaders = configuration.headers
        headerParameters.forEach {
            allHeaders.updateValue($1, forKey: $0)
        }
        if let body = encodableBodyParameters,
           let data = try body.enocoding() {
            urlRequest.httpBody = data
        } else if !bodyParameters.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
}

private extension Encodable {
    func enocoding() throws -> Data? {
        let data = try JSONEncoder().encode(self)
        return data
    }
}
