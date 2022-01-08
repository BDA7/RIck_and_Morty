//
//  PresenterSpecial.swift
//  RIck_and_Morty
//

import UIKit
import RealmSwift


protocol PresenterSpecialProtocol {
    var view: ViewSpecialProtocol? { get set }
    func dataload(data: Results<PersonModel>)
}

final class PresenterSpecial: PresenterSpecialProtocol {
    var view: ViewSpecialProtocol?
}

extension PresenterSpecial {
    func dataload(data: Results<PersonModel>) {
        view?.action(with: .updateModel(res: data))
        view?.action(with: .refreshData)
    }
}
