//
//  Product.swift
//  Rentit
//
//  Created by Eldiiar on 12/11/22.
//

import Foundation

struct Product : Codable {
    let id : Int?
    let userId : Int?
    let name : String?
    let price : Int?
    let condition : String?
    let description : String?
    let address : Address?
    let createdDate : String?
    let views : Int?
    let advertisement : Bool?
    let advertisementDuration : String?
    let advertisementAmount : String?
    let countOfChats : Int?
    let countOfCalls : Int?
    let typeOfRental : String?
    let dateCreated : String?
    let dateUpdated : String?
    let dateDeleted : String?
    let dateDeactivated : String?
    let category : Category?
    let attributesList : [AttributesList]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case userId = "userid"
        case name = "name"
        case price = "price"
        case condition = "condition"
        case description = "description"
        case address = "address"
        case createdDate = "createdDate"
        case views = "views"
        case advertisement = "advertisement"
        case advertisementDuration = "advertisementDuration"
        case advertisementAmount = "advertisementAmount"
        case countOfChats = "countOfChats"
        case countOfCalls = "countOfCalls"
        case typeOfRental = "typeOfRental"
        case dateCreated = "dateCreated"
        case dateUpdated = "dateUpdated"
        case dateDeleted = "dateDeleted"
        case dateDeactivated = "dateDeactivated"
        case category = "category"
        case attributesList = "attributesList"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        condition = try values.decodeIfPresent(String.self, forKey: .condition)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        address = try values.decodeIfPresent(Address.self, forKey: .address)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        views = try values.decodeIfPresent(Int.self, forKey: .views)
        advertisement = try values.decodeIfPresent(Bool.self, forKey: .advertisement)
        advertisementDuration = try values.decodeIfPresent(String.self, forKey: .advertisementDuration)
        advertisementAmount = try values.decodeIfPresent(String.self, forKey: .advertisementAmount)
        countOfChats = try values.decodeIfPresent(Int.self, forKey: .countOfChats)
        countOfCalls = try values.decodeIfPresent(Int.self, forKey: .countOfCalls)
        typeOfRental = try values.decodeIfPresent(String.self, forKey: .typeOfRental)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try values.decodeIfPresent(String.self, forKey: .dateUpdated)
        dateDeleted = try values.decodeIfPresent(String.self, forKey: .dateDeleted)
        dateDeactivated = try values.decodeIfPresent(String.self, forKey: .dateDeactivated)
        category = try values.decodeIfPresent(Category.self, forKey: .category)
        attributesList = try values.decodeIfPresent([AttributesList].self, forKey: .attributesList)
    }

}

struct Category : Codable {
    let id : Int?
    let name : String?
    let parentCategory : ParentCategory?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case parentCategory = "parentCategory"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        parentCategory = try values.decodeIfPresent(ParentCategory.self, forKey: .parentCategory)
    }

}


struct AttributesList : Codable {
    let value : String?
    let attributeId : Int?
    let attributeName : String?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case attributeId = "attributeId"
        case attributeName = "attributeName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        attributeId = try values.decodeIfPresent(Int.self, forKey: .attributeId)
        attributeName = try values.decodeIfPresent(String.self, forKey: .attributeName)
    }

}

struct ParentCategory : Codable {
    let id : Int?
    let name : String?
    let parentCategory : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case parentCategory = "parentCategory"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        parentCategory = try values.decodeIfPresent(String.self, forKey: .parentCategory)
    }

}

struct Address : Codable {
    let id : Int?
    let country : String?
    let city : String?
    let street : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case country = "country"
        case city = "city"
        case street = "street"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        street = try values.decodeIfPresent(String.self, forKey: .street)
    }

}
