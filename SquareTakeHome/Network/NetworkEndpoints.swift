//
//  NetworkEndpoints.swift
//  SquareTakeHome
//
//  Created by Trey Tartt on 4/20/21.
//

import Foundation

enum NetworkEndpoints: String{
    case employees = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    case malformedEmployees = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    case emptyEmpoyees = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
    
    var url: URL {
        return URL(string: self.rawValue)!
    }
}
