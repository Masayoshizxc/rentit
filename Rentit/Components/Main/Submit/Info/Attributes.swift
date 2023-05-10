//
//  InfoModel.swift
//  Rentit
//
//  Created Eldiiar on 11/11/22.
//

struct Attributes: Codable {
    let id: Int?
    let name: String?
    let category: Category?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case category = "category"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        category = try values.decodeIfPresent(Category.self, forKey: .category)
    }
}
