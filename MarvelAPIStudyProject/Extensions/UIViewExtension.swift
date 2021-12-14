//
//  UIViewExtension.swift
//  MarvelAPIStudyProject
//
//  Created by Felipe Lima de Carvalho (P) on 14/12/21.
//

import UIKit

extension UIView {
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = [
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            topAnchor.constraint(equalTo: superView.topAnchor)
        ]
        
        constraint.forEach { (item) in
            item.isActive = true
        }
        
    }
}
