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
    var model: ModelManagerProtocol? { get set }
    func action(with: SpecialInteractorAction)
}


final class InteractorSpecial: InteractorSpecialProtocol {
    var presenter: PresenterSpecialProtocol?
    var model: ModelManagerProtocol?
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
        guard let items = model?.gettingData() else { return }
        presenter?.dataload(data: items)
        
    }

    func viewIsReady() {
        print("Special view is ready")
    }

    func deleteAll() {
        model?.deleteAll()
    }
}
