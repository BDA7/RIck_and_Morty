//
//  ViewController.swift
//  RIck_and_Morty
//
//  Created by d.bondarenko on 07.12.2021.
//

import UIKit

class RootViewController: UITabBarController, UISearchBarDelegate {
    let searchModule = Module.build()
    let specialModule = ModuleSpecial.build()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .backColor
        tabBar.tintColor = .letterColor
        tabBar.backgroundColor = .backColor
        setupViews()
    }


    func setupViews() {
        viewControllers = [
            createNavControllers(for: searchModule, title: StringsConst.titleSearch, image: UIImage(systemName: StringsConst.searchImageOfTitle)!, selectImage: UIImage(systemName: StringsConst.searchImageOfTitle)!),
            createNavControllers(for: specialModule, title: StringsConst.titleSpecial, image: UIImage(systemName: StringsConst.starDefault)!, selectImage: UIImage(systemName: StringsConst.starDefault)!)
        ]
    }

    private func createNavControllers(for rootViewController: UIViewController,
        title: String,
        image: UIImage,
        selectImage: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectImage
        return navController
    }
}


