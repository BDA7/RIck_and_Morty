//
//  InteractorInformation.swift
//  RIck_and_Morty
//



import UIKit


protocol InteractorInfoProtocol: AnyObject {
    var presenter: PresenterInfoProtocol? { get set }
    var router: RouterInformation? { get set }
}

final class InteractorInformation {
    var presenter: PresenterInfoProtocol?
    var router: RouterInformation?
    
}

extension InteractorInformation: InteractorInfoProtocol {
}
