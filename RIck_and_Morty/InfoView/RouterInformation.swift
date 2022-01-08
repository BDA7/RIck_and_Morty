//
//  RouterInformation.swift
//  RIck_and_Morty
//


import UIKit

protocol RouterInfoInput {
    var transitionhandler: InformationIput? { get set }
}

final class RouterInformation {
    weak var transitionhandler: InformationIput?
}

extension RouterInformation: RouterInfoInput {
    
    
}
