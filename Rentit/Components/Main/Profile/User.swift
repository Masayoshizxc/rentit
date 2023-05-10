//
//  User.swift
//  Rentit
//
//  Created by Eldiiar on 13/11/22.
//
// swiftlint:disable all

import Foundation

struct User : Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let middle_name : String?
    let email : String?
    let phoneNumber : String?
    let verificationCode : String?
    let enabled : Bool?
    let dob : String?
    let password : String?
    let premiumSubscription : String?
    let premiumStartTime : String?
    let premiumEndTime : String?
    let premiumsAmount : String?
    let roles : [Roles]?
    let dateCreated : String?
    let dateUpdated : String?
    let dateDeleted : String?
    let following : [String]?
    let savedProducts : [String]?
    let username : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case middle_name = "middle_name"
        case email = "email"
        case phoneNumber = "phoneNumber"
        case verificationCode = "verificationCode"
        case enabled = "enabled"
        case dob = "dob"
        case password = "password"
        case premiumSubscription = "premiumSubscription"
        case premiumStartTime = "premiumStartTime"
        case premiumEndTime = "premiumEndTime"
        case premiumsAmount = "premiumsAmount"
        case roles = "roles"
        case dateCreated = "dateCreated"
        case dateUpdated = "dateUpdated"
        case dateDeleted = "dateDeleted"
        case following = "following"
        case savedProducts = "savedProducts"
        case username = "username"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        middle_name = try values.decodeIfPresent(String.self, forKey: .middle_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        verificationCode = try values.decodeIfPresent(String.self, forKey: .verificationCode)
        enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        premiumSubscription = try values.decodeIfPresent(String.self, forKey: .premiumSubscription)
        premiumStartTime = try values.decodeIfPresent(String.self, forKey: .premiumStartTime)
        premiumEndTime = try values.decodeIfPresent(String.self, forKey: .premiumEndTime)
        premiumsAmount = try values.decodeIfPresent(String.self, forKey: .premiumsAmount)
        roles = try values.decodeIfPresent([Roles].self, forKey: .roles)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try values.decodeIfPresent(String.self, forKey: .dateUpdated)
        dateDeleted = try values.decodeIfPresent(String.self, forKey: .dateDeleted)
        following = try values.decodeIfPresent([String].self, forKey: .following)
        savedProducts = try values.decodeIfPresent([String].self, forKey: .savedProducts)
        username = try values.decodeIfPresent(String.self, forKey: .username)
    }

}

struct Roles : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
