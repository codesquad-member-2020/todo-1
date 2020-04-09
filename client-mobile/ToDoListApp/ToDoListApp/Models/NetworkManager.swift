//
//  NetworkManager.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/09.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

protocol NetworkManagable {
    func requestData(completion: @escaping (Data?, Error?) -> Void)
}

class MockNetworkManager: NetworkManagable {
    
    func requestData(completion: @escaping (Data?, Error?) -> Void) {
        let baseURL = "http://15.165.109.128"
        let path = "/api/columns"
        URLSession.shared.dataTask(with: URL(string: baseURL + path)!) { (data, _, error) in
            if let error = error { completion(nil, error) }
            completion(data, nil)
        }.resume()
    }
    
    func requestColumns(completion: @escaping ([Column]?, Error?) -> Void) {
        requestData { (data, error) in
            if let error = error { completion(nil, error) }
            let decoder = JSONDecoder()
            guard let data = data else { return }
            guard let colums = try? decoder.decode([Column].self, from: data) else { return }
            completion(colums, nil)
        }
    }
}
