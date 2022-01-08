//
//  InformationViewController.swift
//  RIck_and_Morty
//


import UIKit

protocol InformationIput: AnyObject {
    var interactor: InteractorInfoProtocol? { get set }
}

class InformationViewController: UIViewController {
    var interactor: InteractorInfoProtocol?
    var person: Character?

    lazy var imagePerson: UIImageView = {
        let image = UIImageView()
        return image
    }()

    lazy var name: UILabel = {
        let label = UILabel()
        label.text = "RICK Sanchez"
        
        label.textColor = .letterColor
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.font = UIFont(name: "Helvetica", size: 30)
        label.textAlignment = .center
        return label
    }()

    lazy var species: UILabel = {
        let label = UILabel()
        label.text = "Species: "
        label.textColor = .letterColor
        
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()

    lazy var status: UILabel = {
        let label = UILabel()
        label.text = "Status: "
        label.textColor = .letterColor
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()

    lazy var type: UILabel = {
        let label = UILabel()
        label.text = "Type: "
        label.textColor = .letterColor
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()
}

extension InformationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backColor
        setups()
    }
}

extension InformationViewController: InformationIput {
    func setups() {
        setupImage()
        setupName()
        setupType()
        setupStatus()
        setupSpec()
    }

    func setupImage() {
        view.addSubview(imagePerson)
        imagePerson.load(link: person?.image)
        imagePerson.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2.5)
        
        imagePerson.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }
// добавть имя в титул, а это удалить
    func setupName() {
        view.addSubview(name)
        name.text = person?.name
        name.snp.makeConstraints { make in
            make.top.equalTo(imagePerson.snp.bottom).inset(imagePerson.frame.height/8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(imagePerson.snp.bottom)
        }
    }

    func setupSpec() {
        view.addSubview(species)
        species.text = species.text! + (person?.species ?? "")
        species.snp.makeConstraints { make in
            make.top.equalTo(status.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(type.snp.bottom).offset(view.frame.height/20+20)
        }
    }

    func setupStatus() {
        view.addSubview(status)
        choiceStatus()
        status.snp.makeConstraints { make in
            make.top.equalTo(type.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(type.snp.bottom).offset(view.frame.height/20)
        }
    }

    func setupType() {
        view.addSubview(type)
        type.text = type.text! + (person?.type ?? "")
        type.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(name.snp.bottom).offset(view.frame.height/20)
        }
    }


    func choiceStatus() {
        guard let choicingStatus = person?.status else { return }
        switch choicingStatus {
        case "Alive":
            status.text = status.text! + choicingStatus + " 🟢"
        case "Dead":
            status.text = status.text! + choicingStatus + " 🔴"
        default:
            status.text = status.text! + "Unknow" + " ⚫️"
        }
    }

}
