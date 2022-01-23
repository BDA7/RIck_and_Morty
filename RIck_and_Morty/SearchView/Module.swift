//
//  Module.swift
//  RIck_and_Morty
//


class Module {
    static func build() -> SearchViewController {
        let viewController = SearchViewController()
        let router = Router()
        let interactor = Interactor()
        let presenter = Presenter()
        let modelManager = ModelManager()

        viewController.interactor = interactor
        presenter.view = viewController
        interactor.presenter = presenter
        interactor.router = router
        interactor.modelManager = modelManager
        router.transitionHandler = viewController

        return viewController

    }
}
