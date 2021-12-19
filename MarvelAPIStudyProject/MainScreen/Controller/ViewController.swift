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
    private var dataSource = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        mainView.pin(to: view)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainService.marvelApiCall { (data) in
            DispatchQueue.main.async {
                self.dataSource = data
                self.mainView.tableView.reloadData()
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.tableView.frame = view.bounds
    }
    
}

extension ViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! CharactersTableViewCell
        let url = URL(string: dataSource[indexPath.row].thumbnail.path + "/standard_fantastic.jpg")
        if let url = url {
            cell.configureCell(superHeroName: dataSource[indexPath.row].name, superHeroImage: url)
        }
        return cell
    }
}
