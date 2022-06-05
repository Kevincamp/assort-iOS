//
//  Request.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/2/22.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

protocol Request {
    associatedtype ResponseType where ResponseType: Codable
    var session: URLSession { get }
    var httpMethod: HTTPMethod { get }
    var url: String { get }
    var parameters: [String: String] { get }
    var httpBody: [String: Any] { get }
    var additionalHeaders: [String: String] { get }
    func responseModel(data: Data) -> Result<ResponseType, CustomError>
}

extension Request {
    // MARK: - Defaults
    var session: URLSession {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }

    var httpMethod: HTTPMethod { .GET }
    var parameters: [String: String] { [String: String]() }
    var httpBody: [String: Any] { [String: Any]() }
    var additionalHeaders: [String: String] { [String: String]() }

    func responseModel(data: Data) -> Result<ResponseType, CustomError> {
        data.decoded(ResponseType.self)
    }

    // MARK: - Public

    func start(completion: @escaping (Result<ResponseType, CustomError>) -> Void) {
        start(isRetry: false, completion: completion)
    }
    
    func test_start(json: String, delay: Double = 0.0, completion: @escaping (Result<ResponseType, CustomError>) -> Void) {
        Utils.performAfterDelay(delay: delay) {
            let jsonData = Data(json.utf8)
            completion(responseModel(data: jsonData))
        }
    }

    // MARK: - Private

    private func start(isRetry: Bool = false, completion: @escaping (Result<ResponseType, CustomError>) -> Void) {
        guard
            let urlRequest = self.newURLRequest()
        else {
            print("Request Error: - can't create a request for URL: " + url)
            completion(.failure(.invalidURL))
            return
        }

        guard
            NetworkReachability.shared.isConnected
        else {
            completion(.failure(.notConnectedToInternet))
            return
        }

        print(self.httpMethod.rawValue + " " + (urlRequest.url?.absoluteString ?? ""))

        let requestDate = Date()

        session.dataTask(with: urlRequest) { data, response, error in
            print("request duration (\(String(describing: type(of: self)))): \(Date().timeIntervalSince(requestDate))")

            DispatchQueue.main.async {
                if let error = error as NSError? {
                    if error.code == NSURLErrorNotConnectedToInternet {
                        completion(.failure(.notConnectedToInternet))
                        return
                    } else {
                        completion(.failure(.unknown))
                        return
                    }
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }

                switch httpResponse.statusCode {
                case 200..<300:
                    // make sure we got data
                    guard let responseData = data else {
                        completion(.failure(.invalidResponse))
                        return
                    }

                    completion(responseModel(data: responseData))
                case 401, 403, 405, 407:
                    completion(.failure(.unauthorized))
                case 400, 404:
                    completion(.failure(.invalidURL))
                case 500..<511:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unknown))
                }
            }
        }
        .resume()
    }

    private func urlString() -> String { ProjectConfigurationManager.shared.url + url }

    private func queryItems() -> [URLQueryItem]? {
        var result: [URLQueryItem] = []
        for (param, value) in parameters {
            result.append(URLQueryItem(name: param, value: value))
        }
        return !result.isEmpty ? result : nil
    }

    private func newURLRequest() -> URLRequest? {
        var urlComponents = URLComponents(string: urlString())
        urlComponents?.queryItems = queryItems()
        guard let urlObj = urlComponents?.url else { return nil }

        var request = URLRequest(url: urlObj)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = allHTTPHeaderFields()

        if !httpBody.keys.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: .init(rawValue: 0))
        }

        return request
    }

    private func allHTTPHeaderFields() -> [String: String] {
        var result: [String: String] = [:]
        result["Content-Type"] = "application/json; charset=utf-8"

        result = result.merging(additionalHeaders) { $1 }
        return result
    }
}
