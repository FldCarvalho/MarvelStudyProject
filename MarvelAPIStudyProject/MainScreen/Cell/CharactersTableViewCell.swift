//
//  CharactersTableViewCell.swift
//  MarvelAPIStudyProject
//
//  Created by Felipe Lima de Carvalho (P) on 14/12/21.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    lazy var charImageView: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var charLabelView: UILabel = {
        var name = UILabel()
        name.numberOfLines = 0
        name.adjustsFontSizeToFitWidth = true
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(charImageView)
        addSubview(charLabelView)
        setImageConstraints()
        setCharNameConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
    
    func configureCell(superHeroName: String, superHeroImage url: URL) {
        charLabelView.text = superHeroName
        getImageWithURL(url) { data in
            DispatchQueue.main.async {
                self.charImageView.image = UIImage(data: data)
            }
        }
    }
    
    func getImageWithURL(_ url: URL, completion: @escaping ((Data)-> Void)) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            if let data = data {
                completion(data)
            }
        }
        task.resume()
    }
    
    private func setImageConstraints() {
        let constraint = [
            charImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            charImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            charImageView.heightAnchor.constraint(equalToConstant: 80),
            charImageView.widthAnchor.constraint(equalTo: charImageView.heightAnchor, multiplier: 16/9)
        ]
        
        NSLayoutConstraint.activate(constraint)
    }
    
    private func setCharNameConstraints() {
        let constraint = [
            charLabelView.centerYAnchor.constraint(equalTo: centerYAnchor),
            charLabelView.leadingAnchor.constraint(equalTo: charImageView.trailingAnchor, constant: 20),
            charLabelView.heightAnchor.constraint(equalTo: heightAnchor),
            charLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ]
        
        NSLayoutConstraint.activate(constraint)
    }
    
}
