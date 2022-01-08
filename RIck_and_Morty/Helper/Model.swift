//
//  Model.swift
//  RIck_and_Morty
//


import UIKit
import RealmSwift



class PersonModel: Object {
    @objc dynamic var id = Int()
    @objc dynamic var name = ""
    @objc dynamic var image = Data()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

struct SearchRequestModel: Decodable {
    var results: [Character]
}
struct Character: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var image: String
    var isHaving: Bool?
}
