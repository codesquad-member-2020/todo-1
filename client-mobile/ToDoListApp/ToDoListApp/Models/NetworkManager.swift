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
    
    func requestData(method: NetworkManager.methodType, completion: @escaping (Result<RequestData, RequestError>) -> Void)
}

enum RequestError: String, Error, CustomStringConvertible {
    case ServerError = "서버 통신 요청에 실패했습니다."
    case URLSessionError = "네트워크 요청에 실패했습니다."
    case JSONDecodingError = "데이터를 가져오는 중에 오류가 발생했습니다."
    case UnauthorizedError = "아이디와 비밀번호를 확인해주세요"
    
    var description: String {
        return self.rawValue
    }
}

class NetworkManager: NetworkManagable {
    
    typealias RequestData = [Column]?
    
    static let shared = NetworkManager()
    
    private let baseURL = "http://13.124.169.123"
    
    private func requestDataToServer(method: NetworkManager.methodType, completion: @escaping (Result<Data?, RequestError>) -> Void) {
        let successStatusCode = 200
        
        URLSession.shared.dataTask(with: RequestURL(path: .GetColumns, method: method)) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode != successStatusCode { completion(.failure(.ServerError)) }
            if error != nil { completion(.failure(.URLSessionError)) }
            completion(.success(data))
        }.resume()
    }
    
    private func requestLogInToServer(body: Data?, completion: @escaping (Result<String, RequestError>) -> Void) {
        let successStatusCode = 200
        let unauthorizedStatusCode = 401
        
        URLSession.shared.dataTask(with: RequestURL(path: .LogIn, method: .post, body: body)) { (data, response, error) in
            guard
                let url = response?.url,
                let response = response as? HTTPURLResponse,
                let fields = response.allHeaderFields as? [String: String]
                else { return }
            
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
            HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: nil)
            var token = ""
            
            for cookie in cookies {
                var cookieProperties = [HTTPCookiePropertyKey: Any]()
                cookieProperties[.name] = cookie.name
                cookieProperties[.value] = cookie.value
                cookieProperties[.domain] = cookie.domain
                cookieProperties[.path] = cookie.path
                cookieProperties[.version] = cookie.version
                cookieProperties[.expires] = Date().addingTimeInterval(31536000)

                let newCookie = HTTPCookie(properties: cookieProperties)
                HTTPCookieStorage.shared.setCookie(newCookie!)

                token = cookie.value
            }
            switch response.statusCode {
            case unauthorizedStatusCode:
                completion(.failure(.UnauthorizedError))
            case successStatusCode: break
            default: break
            }
            if error != nil { completion(.failure(.URLSessionError)) }
            completion(.success(token))
        }.resume()
    }
    
    func requestData(method: NetworkManager.methodType, completion: @escaping (Result<RequestData, RequestError>) -> Void) {
        requestDataToServer(method: method) { (result) in
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
    
    func requestLogIn(user: User, completion: @escaping (Result<String, RequestError>) -> Void) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(user)
        requestLogInToServer(body: data) { (result) in
            switch result {
            case .success(let token):
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension NetworkManager {
    
    enum path: String, CustomStringConvertible {
        case GetColumns = "/api/columns"
        case LogIn = "/api/login"
        
        var description: String {
            return self.rawValue
        }
    }
    
    enum methodType: String, CustomStringConvertible {
        case get = "get"
        case put = "put"
        case post = "post"
        case delete = "delete"
        
        var description: String {
            return self.rawValue
        }
    }
    
    private func RequestURL(path: path, method: methodType, body: Data? = nil) -> URLRequest {
        let URLForRequest = URL(string: baseURL + path.description)!
        var request = URLRequest(url: URLForRequest)
        request.httpMethod = method.description
        if body != nil {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }
        return request
    }
}
