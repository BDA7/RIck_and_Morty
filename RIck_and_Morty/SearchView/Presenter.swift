//
//  Presenter.swift
//  RIck_and_Morty
//


import UIKit


enum SpecialPresenterAction {
    case dataUpdate(model: [Character]?, ids: [Int])
//    case initCell(button: UIButton, choice: Bool)
}

protocol PresenterProtocol: AnyObject {
    var view: ViewProtocol? { get set }

    func action(with: SpecialPresenterAction)
}

// MARK: - Choice Action
final class Presenter: PresenterProtocol {
    weak var view: ViewProtocol?

    func action(with: SpecialPresenterAction) {
        switch with {
//        case .initCell(let button, let choice):
//            initCell(button: button, choice: choice)
        case .dataUpdate(model: let model, ids: let ids):
            dataUpdate(model: model, ids: ids)
        }
    }
}

// MARK: - Action Methods
extension Presenter {
    func dataUpdate(model: [Character]?, ids: [Int]) {
        guard var searchNew = model else { return }
    
        for i in 0..<searchNew.count {
            if ids.contains(where: {$0 == searchNew[i].id}) {
                searchNew[i].isHaving = true
            } else {
                searchNew[i].isHaving = false
            }
        }
        view?.action(with: .viewUpdate(newModel: searchNew))
    }
}
