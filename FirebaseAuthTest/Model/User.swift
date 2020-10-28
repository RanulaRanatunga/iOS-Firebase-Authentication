//
//  User.swift
//  FirebaseAuthExample
//
//  Created by Pasan Induwara Edirisooriya on 6/24/20.
//  Copyright © 2020 ElegantMedia. All rights reserved.
//

import Foundation



public struct User: Codable {

    public var id: String?
    public var uuid: String?
    public var firstName: String?
    public var lastName: String?
    public var fullName: String?
    public var phone: String?
    public var email: String?
    public var created_at: String?
    public var updated_at: String?

    public init(_id: String?, uuid: String?, firstName: String?, lastName: String?, fullName: String?, phone: String?, email: String?, created_at: String, updated_at: String) {
        self.id = _id
        self.uuid = uuid
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.phone = phone
        self.email = email
        self.created_at = created_at
        self.updated_at = updated_at
    }

    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case uuid
        case firstName = "first_name"
        case lastName = "last_name"
        case fullName = "full_name"
        case phone 
        case email
        case created_at
        case updated_at
    }

}
