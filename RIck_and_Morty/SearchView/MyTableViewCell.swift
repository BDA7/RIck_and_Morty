//
//  MyTableViewCell.swift
//  RIck_and_Morty
//


import UIKit
import SnapKit

class MyTableViewCell: UITableViewCell {

    weak var delegate: ViewProtocol?

    var id: Int?

// MARK: - Views for cell
    lazy var imageOfPerson: UIImageView = {
        let image = UIImageView()
        return image
    }()

    lazy var name: UILabel = {
        let label = UILabel()
        label.text = "John"
        label.textColor = .letterColor
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 19)
        return label
    }()

    lazy var container: UIView = {
        let view = UIView(frame: CGRect(x: 5, y: 5, width: contentView.frame.width-10, height: contentView.frame.height-5))
        view.backgroundColor = .backColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10.0
        view.layer.borderColor = (UIColor.letterColor).cgColor
        view.layer.borderWidth = 1.5
        view.layer.shadowOpacity = 0.2
        return view
    }()

    lazy var addToSpecial: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addToButton), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .secondBackColor

        setupContainer()
        
    }
}

// MARK: - Setups
extension MyTableViewCell {
    
    func setupContainer() {
        contentView.addSubview(container)
        setupImage()
        setupName()
        setupButton()
        
    }

    func setupImage() {
        container.addSubview(imageOfPerson)
        imageOfPerson.frame = CGRect(x: 0, y: 0, width: container.frame.height, height: container.frame.height)
        
    }

    func setupName() {
        container.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalTo(container)
            make.bottom.equalTo(container)
            make.left.equalTo(imageOfPerson.snp.right).offset(container.frame.width/30)
            make.right.equalTo(container).inset(container.frame.width/5)
        }
    }

    func setupButton() {
        container.addSubview(addToSpecial)
        addToSpecial.snp.makeConstraints { make in
            make.top.equalTo(container)
            make.bottom.equalTo(container)
            make.left.equalTo(name.snp.right)
            make.right.equalTo(container)
        }
    }
}

// MARK: - Configurations
extension MyTableViewCell {
    public func configure(id: Int?, nameText: String, img: String, fill: Bool) {
        self.id = id
        name.text = nameText
        imageOfPerson.load(link: img)
        if fill == true {
            addToSpecial.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            addToSpecial.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
        name.text = nil
    }

    @objc func addToButton(_ sender: Any?) {
        guard let id = id else { return }
        guard let del = delegate?.action(with: .actionPerson(id: id, name: name.text ?? " ", image: imageOfPerson.image, button: addToSpecial)) else { return }
    }
}

