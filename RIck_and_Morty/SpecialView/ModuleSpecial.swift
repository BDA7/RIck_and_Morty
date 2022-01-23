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
        let modelManager = ModelManager()

        presenter.view = viewController
        interactor.presenter = presenter
        interactor.modelManager = modelManager
        viewController.interactor = interactor
        return viewController

    }
}
