//
//  Router.swift
//  RIck_and_Morty
//


import UIKit


protocol RouterInput: AnyObject {
    var transitionHandler: UIViewController? { get set }
    func goToInfoView(setting: Character)
}

final class Router: RouterInput {
    weak var transitionHandler: UIViewController?
}
extension Router {
    func goToInfoView(setting: Character) {
        let toViewController = ModuleInformation.build(person: setting)
        transitionHandler?.navigationController?.pushViewController(toViewController, animated: true)
        
    }
}

