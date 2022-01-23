//
//  Interactior.swift
//  RIck_and_Morty
//
//  Created by d.bondarenko on 08.01.2022.
//

import UIKit
import RealmSwift

enum InteractorAction {
    case searchRequest
    case routerUses(character: Character?)
    case actionDataBase(id: Int, name: String, image: UIImage)
    case flag(name: String, button: UIButton)
    case setQueryText(text: String)
    case updateView
}

protocol InteractorProtocol: AnyObject {
    var presenter: PresenterProtocol? { get set }
    var router: RouterInput? { get set }
    var modelManager: ModelManager? { get set }

    func viewIsReady()
    func action(with: InteractorAction)
}

final class Interactor: InteractorProtocol {
    func viewIsReady() {}

    var presenter: PresenterProtocol?
    var view: ViewProtocol?
    var modelManager: ModelManager?
    var router: RouterInput?
    let net = Network()
    var pres = Presenter()
    var queryText: String = ""
    fileprivate var characters = [Character]()


    func action(with: InteractorAction) {
        switch with {
            
        case .searchRequest:
            searchRequestStart()
        case .routerUses(character: let character):
            routeInfo(character: character)
        case .flag(name: let name, button: let button):
            initCell(button: button, name: name)
        case .actionDataBase(id: let id, name: let name, image: let image):
            modelManager?.actionFromDB(id: id, name: name, image: image)
            guard let ids = modelManager?.ids() else { return }
            presenter?.action(with: .dataUpdate(model: characters, ids: ids))
        case .updateView:
            guard let ids = modelManager?.ids() else { return }
            presenter?.action(with: .dataUpdate(model: characters, ids: ids))
        case .setQueryText(text: let text):
            setQueryText(textQuery: text)
        }
    }
}
extension Interactor {
    func setQueryText(textQuery: String) {
        self.queryText = textQuery
    }

    func completeStringQuery() -> String {
        return StringsConst.urlForAlbum + self.queryText
    }
}

extension Interactor {
    func searchRequestStart() {
        net.request(urlString: completeStringQuery()) { [weak self] (result) in
            switch result {

            case .success(let searchRequest):
                self?.characters = searchRequest.results
                guard let ids = self?.modelManager?.ids() else { return }
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

extension Interactor {
    func initCell(button: UIButton, name: String) {
        guard let flag = modelManager?.flag(name: name) else { return }
        if flag {
            button.setImage(UIImage(systemName: StringsConst.starFill), for: .normal)
        } else {
            button.setImage(UIImage(systemName: StringsConst.starDefault), for: .normal)
        }
    }
}
