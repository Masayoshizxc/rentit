//
//  ProfileModel.swift
//  Rentit
//
//  Created Eldiiar on 13/11/22.
//

struct MyProducts : Codable {
    let id : Int?
    let name : String?
    let price : Double?
    let condition : String?
    let description : String?
    let createdDate : String?
    let views : Int?
    let advertisement : Bool?
    let advertisementDuration : String?
    let advertisementAmount : String?
    let countOfChats : Int?
    let countOfCalls : Int?
    let typeOfRental : String?
    let idActive : String?
    let dateCreated : String?
    let dateUpdated : String?
    let dateDeleted : String?
    let dateDeactivated : String?
    let address : Address?
    let category : Category?
//    let attributesList : [AttributesList]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case price = "price"
        case condition = "condition"
        case description = "description"
        case createdDate = "createdDate"
        case views = "views"
        case advertisement = "advertisement"
        case advertisementDuration = "advertisementDuration"
        case advertisementAmount = "advertisementAmount"
        case countOfChats = "countOfChats"
        case countOfCalls = "countOfCalls"
        case typeOfRental = "typeOfRental"
        case idActive = "idActive"
        case dateCreated = "dateCreated"
        case dateUpdated = "dateUpdated"
        case dateDeleted = "dateDeleted"
        case dateDeactivated = "dateDeactivated"
        case address = "address"
        case category = "category"
//        case attributesList = "attributesList"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        condition = try values.decodeIfPresent(String.self, forKey: .condition)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        views = try values.decodeIfPresent(Int.self, forKey: .views)
        advertisement = try values.decodeIfPresent(Bool.self, forKey: .advertisement)
        advertisementDuration = try values.decodeIfPresent(String.self, forKey: .advertisementDuration)
        advertisementAmount = try values.decodeIfPresent(String.self, forKey: .advertisementAmount)
        countOfChats = try values.decodeIfPresent(Int.self, forKey: .countOfChats)
        countOfCalls = try values.decodeIfPresent(Int.self, forKey: .countOfCalls)
        typeOfRental = try values.decodeIfPresent(String.self, forKey: .typeOfRental)
        idActive = try values.decodeIfPresent(String.self, forKey: .idActive)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try values.decodeIfPresent(String.self, forKey: .dateUpdated)
        dateDeleted = try values.decodeIfPresent(String.self, forKey: .dateDeleted)
        dateDeactivated = try values.decodeIfPresent(String.self, forKey: .dateDeactivated)
        address = try values.decodeIfPresent(Address.self, forKey: .address)
        category = try values.decodeIfPresent(Category.self, forKey: .category)
//        attributesList = try values.decodeIfPresent([AttributesList].self, forKey: .attributesList)
    }

}
