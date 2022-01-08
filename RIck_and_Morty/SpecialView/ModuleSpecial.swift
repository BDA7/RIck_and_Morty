//
//  ModuleSpecial.swift
//  RIck_and_Morty
//


import UIKit

class ModuleSpecial {
    static func build() -> SpecialViewController {
        let viewController = SpecialViewController()

        let interactor = InteractorSpecial()
        let presenter = PresenterSpecial()
        let model = ModelManager()

        presenter.view = viewController

        interactor.presenter = presenter
        interactor.model = model

        viewController.interactor = interactor

        return viewController

    }
}
