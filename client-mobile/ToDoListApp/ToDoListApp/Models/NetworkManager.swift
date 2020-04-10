//
//  NetworkManager.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/09.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

protocol NetworkManagable {
    associatedtype RequestData
    
    func requestData(completion: @escaping (Result<RequestData, RequestError>) -> Void)
}

enum RequestError: Error {
    case ServerError
    case URLSessionError
    case JSONDecodingError
}

class MockNetworkManager: NetworkManagable {
    typealias RequestData = [Column]?
    
    static let shared = MockNetworkManager()
    
    private func requestDataToServer(completion: @escaping (Result<Data?, RequestError>) -> Void) {
        let baseURL = "http://15.165.109.128"
        let path = "/api/columns"
        let successStatusCode = 200
        
        URLSession.shared.dataTask(with: URL(string: baseURL + path)!) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode != successStatusCode { completion(.failure(.ServerError)) }
            if error != nil { completion(.failure(.URLSessionError)) }
            completion(.success(data))
        }.resume()
    }
    
    func requestData(completion: @escaping (Result<RequestData, RequestError>) -> Void) {
        requestDataToServer { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                guard let data = data else { return }
                guard let userData = try? decoder.decode(UserData.self, from: data) else { return }
                completion(.success(userData.columns))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
