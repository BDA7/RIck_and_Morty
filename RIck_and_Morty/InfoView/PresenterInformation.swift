//
//  PresenterInformation.swift
//  RIck_and_Morty
//


import UIKit
protocol PresenterInfoProtocol {
    var view: InformationIput? { get set }
}

final class PresenterInformation {
    var view: InformationIput?
}

extension PresenterInformation: PresenterInfoProtocol {
}

