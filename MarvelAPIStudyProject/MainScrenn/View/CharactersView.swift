//
//  CharactersView.swift
//  MarvelAPIStudyProject
//
//  Created by Felipe Lima de Carvalho (P) on 14/12/21.
//

import UIKit

class CharactersView: UIView {
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.rowHeight = 100
        tableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: "mainCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(tableView)
        tableView.pin(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
