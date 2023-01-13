//
//  NetworkService.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/04.
//

import Foundation

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case urlGeneration
    case noResponse
    case parsing(Error)
}

protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest, completion: @escaping CompletionHandler)
}

final class DefaultNetworkSessionManager: NetworkSessionManager {
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}

final class NetworkService {
    let configuration: NetworkConfigurable
    let sessionManager: NetworkSessionManager
    
    init(configuration: NetworkConfigurable,
         sessionManager: NetworkSessionManager = DefaultNetworkSessionManager()) {
        self.configuration = configuration
        self.sessionManager = sessionManager
    }
    
    func request<E>(with endpoint: E, completion: @escaping (Result<Void, NetworkError>) -> Void) where E: Requestable, E.Response == Void {
        do {
            let urlRequest = try endpoint.urlRequest(with: configuration)
            sessionManager.request(urlRequest) { data, response, error in
                if error != nil {
                    var networkError: NetworkError
                    if let response = response as? HTTPURLResponse {
                        networkError = .error(statusCode: response.statusCode, data: data)
                    } else {
                        networkError = .noResponse
                    }
                    completion(.failure(networkError))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(NetworkError.urlGeneration))
        }
    }
    
    func request<E, T>(with endpoint: E, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T == E.Response, E: Requestable {
        do {
            let urlRequest = try endpoint.urlRequest(with: configuration)
            sessionManager.request(urlRequest) { data, response, error in
                if error != nil {
                    var networkError: NetworkError
                    if let response = response as? HTTPURLResponse {
                        networkError = .error(statusCode: response.statusCode, data: data)
                    } else {
                        networkError = .noResponse
                    }
                    completion(.failure(networkError))
                } else {
                    let result: Result<T, NetworkError> = self.decode(data: data)
                    switch result {
                    case .success(let decoded):
                        completion(.success(decoded))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        } catch {
            completion(.failure(NetworkError.urlGeneration))
        }
    }
    
    //MARK: - Try Async/await
    func request<E, T>(with endpoint: E) async throws -> T where T: Decodable, T == E.Response, E: Requestable {
        guard let urlRequest = try? endpoint.urlRequest(with: configuration) else { throw NetworkError.urlGeneration }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        if let response = response as? HTTPURLResponse, response.statusCode != 200 { throw NetworkError.error(statusCode: response.statusCode, data: data) }
        let result: T = try decode(data: data)
        return result
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let result: T = try decoder.decode(T.self, from: data)
        return result
    }
    
    private func decode<T: Decodable>(data: Data?) -> Result<T, NetworkError> {
        let decoder = JSONDecoder()
        do {
            guard let data = data else {
                return .failure(NetworkError.noResponse)
            }
            let result: T = try decoder.decode(T.self, from: data)
            return .success(result)
        } catch let error {
            return .failure(NetworkError.parsing(error))
        }
    }
}
