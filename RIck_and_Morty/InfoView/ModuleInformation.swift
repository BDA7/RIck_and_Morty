//
//  ModuleInformation.swift
//  RIck_and_Morty
//


import UIKit

class ModuleInformation {
    static func build(person: Character?) ->InformationViewController {
        let view = InformationViewController()
        view.person = person

        let presenter = PresenterInformation()
        let interactor = InteractorInformation()
        let router = RouterInformation()

        presenter.view = view

        interactor.presenter = presenter
        interactor.router = router

        router.transitionhandler = view

        view.interactor = interactor
        
        
        return view
    }
}
