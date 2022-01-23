//
//  SearchViewController.swift
//  RIck_and_Morty
//

import UIKit


enum SearchAction {
    case viewUpdate(newModel: [Character])
    case choiseFill(name: String, button: UIButton)
    case actionPerson(id: Int, name: String, image: UIImage?, button: UIButton)
}

protocol ViewProtocol: AnyObject {
    var interactor: InteractorProtocol? { get set }
    var searchRequestModel: SearchRequestModel? { get set }

    func action(with: SearchAction)
}

// MARK: - Setup SearchController
final class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ViewProtocol {
    var interactor: InteractorProtocol?
    var searchRequestModel: SearchRequestModel?
    var model = [Character]()
    let searchController = UISearchController(searchResultsController: nil)

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MyTableViewCell.self))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}

extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backColor
        self.navigationController?.navigationBar.barTintColor = UIColor.secondBackColor
        setupTable()
        setupSearcBar()
        interactor?.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.action(with: .updateView)
    }

    func viewUpdate(newModel: [Character]) {
        self.model = newModel
        tableView.reloadData()
    }
}

// MARK: - Action with SearchController
extension SearchViewController {
    func action(with: SearchAction) {
        switch with {
        
        case .choiseFill(let name, let button):
            choiseFill(name: name, button: button)
        case .actionPerson(let id, let name, let image, let button):
            actionPerson(id: id, name: name, image: image, button: button)
        case .viewUpdate(newModel: let newModel):
            viewUpdate(newModel: newModel)
        }
    }
}

// MARK: - Table Configuration
extension SearchViewController {

    func setupTable() {
        view.addSubview(tableView)
        tableView.backgroundColor = .secondBackColor
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        self.tableView.separatorColor = .clear
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MyTableViewCell.self), for: indexPath) as? MyTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        }

        let cellInput = model[indexPath.row]
        cell.delegate = self
        cell.configure(id: cellInput.id, nameText: cellInput.name, img: cellInput.image, fill: cellInput.isHaving ?? false)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = model[indexPath.row]
        interactor?.action(with: .routerUses(character: info))
    }

}

// MARK: - SearchController Configuration
extension SearchViewController: UISearchBarDelegate {
    func setupSearcBar() {
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        searchController.searchBar.tintColor = .letterColor
        searchController.searchBar.searchTextField.textColor = .letterColor
        searchController.searchBar.backgroundColor = .secondBackColor
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.letterColor]
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let stx = searchText.replacingOccurrences(of: " ", with: "")
        interactor?.action(with: .setQueryText(text: stx))
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        interactor?.action(with: .searchRequest)
    }
}

// MARK: - Choise Cell button image
extension SearchViewController {

    func choiseFill(name: String, button: UIButton) {
        interactor?.action(with: .flag(name: name, button: button))
    }

    func actionPerson(id: Int, name: String, image: UIImage?, button: UIButton) {
        interactor?.action(with: .actionDataBase(id: id, name: name, image: (image ?? UIImage(named: "nullImage"))!))
    }
}
