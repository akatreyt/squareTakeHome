//
//  Employee.swift
//  SquareTakeHome
//
//  Created by Trey Tartt on 4/20/21.
//

import Foundation

struct Employee: Codable, Identifiable {
    var id = UUID()
    
    let uuid, fullName, phoneNumber, emailAddress: String
    let biography, photoURLSmall, photoURLLarge, team: String
    let employeeType: String

    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
}
