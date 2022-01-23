//
//  Network.swift
//  RIck_and_Morty
//


import UIKit

class Network {
    func request(urlString: String, completion: @escaping (Result<SearchRequestModel, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                print(data)
                do {
                    let characters = try JSONDecoder().decode(SearchRequestModel.self, from: data)
                    completion(.success(characters))
                } catch  let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}

extension UIImageView {
    func load(link: String?) {
        if link != " ", link != nil {
            guard let url = URL(string: link! ) else { return }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        } else {
            self.image = UIImage(named: "nullImage")
        }
    }
}

extension UIColor {
    static var backColor: UIColor {
        return UIColor(red: 14.0 / 255.0, green: 174.0 / 255.0, blue: 202.0 / 255.0, alpha: 1.0)
    }

    static var letterColor: UIColor {
        return UIColor(red: 245.0 / 255.0, green: 250.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
    }

    static var secondBackColor: UIColor {
        return UIColor(red: 11.0 / 255.0, green: 146.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
    }
}

