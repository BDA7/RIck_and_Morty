//
//  Interactior.swift
//  RIck_and_Morty
//
//  Created by d.bondarenko on 08.01.2022.
//

import UIKit
import RealmSwift

enum InteractorAction {
    case searchRequest(url: String)
    case routerUses(character: Character?)
    case actionDataBase(id: Int, name: String, image: UIImage)
    case flag(name: String, button: UIButton)
    case updateView
}

protocol InteractorProtocol: AnyObject {

    var presenter: PresenterProtocol? { get set }

    var router: RouterInput? { get set }

    var model: ModelManager? { get set }

    func viewIsReady()

    func action(with: InteractorAction)
}

final class Interactor: InteractorProtocol {

    func viewIsReady() {
        print("view Is ready")
    }

    var presenter: PresenterProtocol?
    var view: ViewProtocol?
    var model: ModelManager?
    var router: RouterInput?
    let net = Network()
    var pres = Presenter()
    fileprivate var characters = [Character]()


    func action(with: InteractorAction) {
        switch with {
            
        case .searchRequest(url: let url):
            searchRequestStart(url: url)
        case .routerUses(character: let character):
            routeInfo(character: character)
        case .flag(name: let name, button: let button):
            presenter?.action(with: .initCell(button: button, choice: model?.flag(name: name) ?? false))
        case .actionDataBase(id: let id, name: let name, image: let image):
            model?.actionFromDB(id: id, name: name, image: image)
            guard let ids = model?.ids() else { return }
            presenter?.action(with: .dataUpdate(model: characters, ids: ids))
        case .updateView:
            guard let ids = model?.ids() else { return }
            presenter?.action(with: .dataUpdate(model: characters, ids: ids))
        }
    }
    
}
extension Interactor {
    func searchRequestStart(url: String) {
            net.request(urlString: "https://rickandmortyapi.com/api/character/?name=\(url)") { [weak self] (result) in
            switch result {

            case .success(let searchRequest):
                self?.characters = searchRequest.results
                guard let ids = self?.model?.ids() else { return }
                self?.presenter?.action(with: .dataUpdate(model: self?.characters, ids: ids))
            case .failure(let error):
                print(error)
            }
        }
    }

    func routeInfo(character: Character?) {
        guard let character = character else { return }
        router?.goToInfoView(setting: character)
    }
}
