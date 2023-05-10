//
//  AuthModel.swift
//  Rentit
//
//  Created Eldiiar on 15/10/22.
//

struct LoginModel: Codable {
    let token : String?
    let type : String?
    let id : Int?
    let username : String?
    let email : String?
    let phoneNumber : String?
    let roles : [String]?

    enum CodingKeys: String, CodingKey {

        case token = "token"
        case type = "type"
        case id = "id"
        case username = "username"
        case email = "email"
        case phoneNumber = "phoneNumber"
        case roles = "roles"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        roles = try values.decodeIfPresent([String].self, forKey: .roles)
    }

}
