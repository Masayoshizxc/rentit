//
//  AboutProduct.swift
//  Rentit
//
//  Created by Eldiiar on 16/11/22.
//

import Foundation
//
//struct AboutProduct : Codable {
//    let productid : String?
//    let userid : Int?
//    let name : String?
//    let price : Int?
//    let condition : String?
//    let description : String?
//    let views : Int?
//    let dateCreated : String?
//    let address : Address?
//    let category : Category?
//    let countOfChats : Int?
//    let countOfCalls : Int?
//    let typeOfRental : String?
//    let rating : Int?
//    let imagesList : [String]?
//    let attributesList : [AttributesList]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case productid = "productid"
//        case userid = "userid"
//        case name = "name"
//        case price = "price"
//        case condition = "condition"
//        case description = "description"
//        case views = "views"
//        case dateCreated = "dateCreated"
//        case address = "address"
//        case category = "category"
//        case countOfChats = "countOfChats"
//        case countOfCalls = "countOfCalls"
//        case typeOfRental = "typeOfRental"
//        case rating = "rating"
//        case imagesList = "imagesList"
//        case attributesList = "attributesList"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        productid = try values.decodeIfPresent(String.self, forKey: .productid)
//        userid = try values.decodeIfPresent(Int.self, forKey: .userid)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        price = try values.decodeIfPresent(Int.self, forKey: .price)
//        condition = try values.decodeIfPresent(String.self, forKey: .condition)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        views = try values.decodeIfPresent(Int.self, forKey: .views)
//        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
//        address = try values.decodeIfPresent(Address.self, forKey: .address)
//        category = try values.decodeIfPresent(Category.self, forKey: .category)
//        countOfChats = try values.decodeIfPresent(Int.self, forKey: .countOfChats)
//        countOfCalls = try values.decodeIfPresent(Int.self, forKey: .countOfCalls)
//        typeOfRental = try values.decodeIfPresent(String.self, forKey: .typeOfRental)
//        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
//        imagesList = try values.decodeIfPresent([String].self, forKey: .imagesList)
//        attributesList = try values.decodeIfPresent([AttributesList].self, forKey: .attributesList)
//    }
//
//}
