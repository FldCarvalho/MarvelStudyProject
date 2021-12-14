//
//  ViewController.swift
//  MarvelAPIStudyProject
//
//  Created by Felipe Lima de Carvalho (P) on 14/12/21.
//

import UIKit

class ViewController: UIViewController {

    let mainView = CharactersView()
    let mainService = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        mainView.pin(to: view)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainService.marvelApiCall(using: {
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
            })
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.tableView.frame = view.bounds
    }
    
}

extension ViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainService.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! CharactersTableViewCell
        cell.charLabelView.text = mainService.characters[indexPath.row].name
        let url = URL(string: mainService.characters[indexPath.row].thumbnail.path + "/standard_fantastic.jpg")!
        getImageWithURL(url) { data in
            DispatchQueue.main.async {
                cell.charImageView.image = UIImage(data: data)
            }
            
        }
        return cell
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
}
