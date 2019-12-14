//
//  APIProvider.swift
//  WordQuiz
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

class APIProvider<T: Decodable> {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request(_ endPoint: RouterService,
                 completion: @escaping (Result<T, NetworkError>) -> Void) {
        let urlComponents = URLComponents(endPoint: endPoint)
        
        if let url = urlComponents.url {
            let request = URLRequest(url: url)

            print("Request: \(request)")
            let task = session.dataTask(with: request) { result in
                self.handleResult(result: result, completion: completion)
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                task.resume()
            }
        }
    }
    
    private func handleResult<T: Decodable>(result: Result<(URLResponse, Data), Error>,
                                            completion: (Result<T, NetworkError>) -> Void) {
        switch result {
        case .failure(let error):
            completion(.failure(NetworkError.connectionError(error)))
        case .success(let response, let data):
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.noResponseData))
                return
            }
            guard let dataString = String(bytes: data, encoding: .utf8) else { return }
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let model = try data.decode(type: T.self)
                    completion(.success(model))
                } catch {
                    completion(.failure(NetworkError.decodeError(error)))
                }
            case 400...499:
                completion(.failure(NetworkError.clientError(statusCode: httpResponse.statusCode,
                                                             dataResponse: dataString)))
            case 500...599:
                completion(.failure(NetworkError.serverError(statusCode: httpResponse.statusCode,
                                                             dataResponse: dataString)))
            default:
                completion(.failure(NetworkError.unknown))
            }
        }
    }
    
}
