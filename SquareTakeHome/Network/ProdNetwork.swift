//
//  NetworkLayer.swift
//  SquareTakeHome
//
//  Created by Trey Tartt on 4/20/21.
//

import Foundation

public final class ProdNetwork: DataFetchable {
    public func retrieveEmployees(fromEndpoint endpoint: URL, completion: @escaping (Result<EmployeeReturn, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: endpoint) {[weak self] (data, response, error) in
            if let error = error{
                completion(.failure(.SessionError(endpoint, error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.NoData(endpoint)))
                return
            }
            
            guard let response = response else{
                completion(.failure(.InvalidResponse(endpoint)))
                return
            }
            
            self?.parse(data, withResponse: response, usingComp: completion)
        }.resume()
    }
}
