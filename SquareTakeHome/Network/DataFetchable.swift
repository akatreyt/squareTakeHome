//
//  DataFetchable.swift
//  SquareTakeHome
//
//  Created by Trey Tartt on 4/20/21.
//

import Foundation

// Use a protocol so mock object can be made with the same signature for testing
protocol DataFetchable {
    /**
     * Fetch data from a URL, parse, and return using Result<EmployeeReturn, NetworkError>
     *
     * - Parameters:
     *   - fromEndpoint: The URL to fetch the employee data from
     *   - completion: Closure to return the EmployeeReturn object or NetworkError
     * - Returns: Void
     */
    func retrieveEmployees(fromEndpoint endpoint: URL, completion: @escaping (Result<EmployeeReturn, NetworkError>) -> Void)
}

extension DataFetchable{
    func parse(_ data: Data, withResponse resp: URLResponse, usingComp comp: @escaping (Result<EmployeeReturn, NetworkError>) -> Void) {
        if let httpResponse = resp as? HTTPURLResponse {
            if httpResponse.statusCode != 200 {
                DispatchQueue.main.async {
                    comp(.failure(.InvalidHTTPCode(resp.url!, httpResponse.statusCode)))
                }
                return
            }
        }else{
            DispatchQueue.main.async {
                comp(.failure(.InvalidResponse(resp.url!)))
            }
            return
        }
        
        do{
            let apiReturn  = try JSONDecoder().decode(EmployeeReturn.self, from: data)
            DispatchQueue.main.async {
                comp(.success(apiReturn))
            }
        }catch{
            DispatchQueue.main.async {
                comp(.failure(.ErrorDecoding(error)))
            }
        }
    }
}
