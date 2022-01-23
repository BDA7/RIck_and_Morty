//
//  InteractorSpecial.swift
//  RIck_and_Morty
//

import UIKit
import RealmSwift


enum SpecialInteractorAction {
    case gettingData
    case viewIsReady
    case deleteAll
}

protocol InteractorSpecialProtocol {
    var presenter: PresenterSpecialProtocol? { get set }
    var modelManager: ModelManagerProtocol? { get set }
    func action(with: SpecialInteractorAction)
}


final class InteractorSpecial: InteractorSpecialProtocol {
    var presenter: PresenterSpecialProtocol?
    var modelManager: ModelManagerProtocol?
}

// MARK: - Actions Interactor
extension InteractorSpecial  {

    func action(with: SpecialInteractorAction) {
        switch with {
        case .gettingData:
            gettingData()
        case .viewIsReady:
            viewIsReady()
        case .deleteAll:
            deleteAll()
        }
    }

    func gettingData() {
        guard let items = modelManager?.gettingData() else { return }
        presenter?.dataload(data: items)
    }

    func viewIsReady() {}

    func deleteAll() {
        modelManager?.deleteAll()
    }
}
