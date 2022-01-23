//
//  ModelManager.swift
//  RIck_and_Morty
//


import UIKit
import RealmSwift

// добавить инфо персонажам

protocol ModelManagerProtocol {
    func actionFromDB(id:Int, name: String, image: UIImage?)
    func flag(name: String) -> Bool
    func gettingData() -> Results<PersonModel>
    func deleteAll()
    func ids() -> [Int]
}

class ModelManager: ModelManagerProtocol{
    
    let realm = try! Realm()

    var items: Results<PersonModel>!

    func ids() -> [Int] {
        var ids = [Int]()
        let models = gettingData()
        for i in 0..<models.count {
            ids.append(models[i].id)
        }
        return ids
    }

    func flag(name: String) -> Bool {
        let pers = realm.objects(PersonModel.self).filter("name = '\(name)'")
        if pers.count == 0 {
            return false
        } else {
            return true
        }
    }
    func actionFromDB(id:Int, name: String, image: UIImage?) {
        if flag(name: name) == false {
            guard let image = image else { return }
            addPerson(id: id, name: name, image: image)
        } else {
            deletePerson(name: name)
        }
    }
    
    func addPerson(id: Int, name: String, image: UIImage) {
        try! realm.write {
            let model = PersonModel()
            model.id = id
            model.name = name
            model.image = image.jpegData(compressionQuality: 1.0) ?? Data()
            
            realm.add(model)
        }
    }

    func deletePerson(name: String) {
        let pers = realm.objects(PersonModel.self).filter("name = '\(name)'")
        try! realm.write {
            realm.delete(pers)
        }
    }

    func gettingData() -> Results<PersonModel> {
        items = realm.objects(PersonModel.self)
        return items
    }

    func deleteAll() {
        try! realm.write{
            realm.deleteAll()
        }
    }
}

