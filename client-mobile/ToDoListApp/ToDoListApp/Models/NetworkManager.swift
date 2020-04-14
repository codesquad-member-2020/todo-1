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

enum RequestError: String, Error, CustomStringConvertible {
    case ServerError = "서버 통신 요청에 실패했습니다."
    case URLSessionError = "네트워크 요청에 실패했습니다."
    case JSONDecodingError = "데이터를 가져오는 중에 오류가 발생했습니다."
    
    var description: String {
        return self.rawValue
    }
}

class NetworkManager: NetworkManagable {
    
    typealias RequestData = [Column]?
    
    static let shared = NetworkManager()
    
    private let baseURL = "http://13.124.169.123"
    
    private func requestDataToServer(completion: @escaping (Result<Data?, RequestError>) -> Void) {
        let successStatusCode = 200
        
        URLSession.shared.dataTask(with: RequestURL(path: .GetColumns)) { (data, response, error) in
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
                guard let userData = try? decoder.decode(UserData.self, from: data) else {
                    completion(.failure(.JSONDecodingError))
                    return
                }
                completion(.success(userData.columns))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension NetworkManager {
    
    enum path: String, CustomStringConvertible {
        case GetColumns = "/api/columns"
        
        var description: String {
            return self.rawValue
        }
    }
    
    private func RequestURL(path: path) -> URL {
        return URL(string: baseURL + path.description)!
    }
}
