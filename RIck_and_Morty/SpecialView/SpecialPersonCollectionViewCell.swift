//
//  SpecialPersonCollectionViewCell.swift
//  RIck_and_Morty
//


import UIKit

class SpecialPersonCollectionViewCell: UICollectionViewCell {
  
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContainer()
        setupImage()
        setupName()
    }

    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .backColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10.0
        view.layer.borderColor = (UIColor.letterColor).cgColor
        view.layer.borderWidth = 1.5
        view.layer.shadowOpacity = 0.2
        return view
    }()

    lazy var name: UILabel = {
        let label = UILabel()
        label.backgroundColor = .backColor
        label.textColor = .letterColor
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 15)
        
        return label
    }()

    lazy var image: UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .red
        return image
    }()


    func setupContainer() {
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
        
    func setupName() {
        container.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom)
            make.bottom.equalTo(container)
            make.left.equalTo(container)
            make.right.equalTo(container)
        }
    }

    func setupImage() {
        container.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalTo(container)
            make.bottom.equalTo(container).inset(contentView.frame.height/3.5-20)
            make.left.equalTo(container)
            make.right.equalTo(container)
        }
    }

    public func configure(nameText: String, urlImage: Data) {
        name.text = nameText
        image.image = UIImage(data: urlImage)
    }
}
