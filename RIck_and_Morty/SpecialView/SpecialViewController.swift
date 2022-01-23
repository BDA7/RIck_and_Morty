//
//  SpecialViewController.swift
//  RIck_and_Morty
//

import UIKit
import RealmSwift


enum SpecialViewControllerAction {
    case refreshData
    case updateModel(res: Results<PersonModel>)
}

protocol ViewSpecialProtocol {
    var interactor: InteractorSpecialProtocol? { get set }
    func action(with: SpecialViewControllerAction)
}

class SpecialViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var interactor: InteractorSpecialProtocol?

    var items: Results<PersonModel>?

    lazy var specialCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width/2.1, height: view.frame.width/2.1)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .backColor
        collectionView.register(SpecialPersonCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(SpecialPersonCollectionViewCell.self))

        return collectionView
    }()
}

extension SpecialViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backColor
        self.navigationController?.navigationBar.barTintColor = UIColor.secondBackColor
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.letterColor]
        interactor?.action(with: .gettingData)
        setupCollection()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAll))
        interactor?.action(with: .viewIsReady)
    }

    override func viewWillAppear(_ animated: Bool) {
        interactor?.action(with: .gettingData)
    }
}

extension SpecialViewController: ViewSpecialProtocol {
    func action(with: SpecialViewControllerAction) {
        switch with {
        case .refreshData:
            refreshData()
        case .updateModel(let res):
            updateModel(res: res)
        }
    }
    
    
    func updateModel(res: Results<PersonModel>) {
        self.items = res
        refreshData()
    }

    func refreshData() {
        specialCollectionView.reloadData()
    }

    @objc func deleteAll(_ sender: AnyObject) {
        interactor?.action(with: .deleteAll)
        specialCollectionView.reloadData()
    }
}

extension SpecialViewController {
    func setupCollection() {
        view.addSubview(specialCollectionView)
        specialCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        specialCollectionView.backgroundColor = .secondBackColor
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(SpecialPersonCollectionViewCell.self), for: indexPath) as! SpecialPersonCollectionViewCell
        guard let data = items?[indexPath.row] else { return cell }
        cell.configure(nameText: data.name, urlImage: data.image)
        
        return cell
    }

}
