//
//  MockNetwork.swift
//  SquareTakeHome
//
//  Created by Trey Tartt on 4/20/21.
//

import Foundation

public final class MockNetwork: DataFetchable {
    public func retrieveEmployees(fromEndpoint endpoint: URL, completion: @escaping (Result<EmployeeReturn, NetworkError>) -> Void) {
        if let networkEndpoint = NetworkEndpoints(rawValue: endpoint.absoluteString){
            var fileName:String?
            
            switch networkEndpoint {
             case .employees:
                fileName = "EmployeeData.json"
            case .malformedEmployees:
                fileName = "EmployeeMalformed.json"
            case .emptyEmployees:
                fileName = "EmployeeEmpty.json"
            }
            
            guard let _fileName = fileName else {
                fatalError()
            }
            
            do{
                let path = Bundle.main.bundleURL.appendingPathComponent(_fileName)
                let data = try Data.init(contentsOf: path)
                let urlResponse = HTTPURLResponse(url: endpoint,
                                                  statusCode: 200,
                                                  httpVersion: "1.1",
                                                  headerFields: nil)!
                
                self.parse(data, withResponse: urlResponse, usingComp: completion)
            }catch{
                DispatchQueue.main.async {
                    completion(.failure(.Unkown(endpoint, error)))
                }
            }
        }else{
            DispatchQueue.main.async {
                completion(.failure(.InvalidURL(endpoint.absoluteString)))
            }
        }
        
    }
}
