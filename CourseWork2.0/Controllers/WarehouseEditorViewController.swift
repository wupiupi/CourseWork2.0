//
//  WarehouseEditorViewController.swift
//  CourseWork2.0
//
//  Created by Paul Makey on 23.11.23.
//

import UIKit
import Firebase

class WarehouseEditorViewController: UIViewController {
    
    // MARK: - Variables
    var areWeAdding = true
    
    private let headerView = AuthHeaderView(
        title: "Attention",
        subtitle: "You want to delete item from a list."
    )
    
    private let doneButton = CustomButton(
        title: "Done",
        hasBackground: true,
        fontSize: .medium,
        textColor: .label
    )
    
    
    // MARK: - UI Components
    let textField = CustomTextField(fieldType: .label)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(areWeAdding)
        
        setupUI()
        
        doneButton.addTarget(
            self,
            action: #selector(
                didTapDone
            ),
            for: .touchUpInside
        )
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
         
        self.view.backgroundColor = .systemGray6
        
        self.view.addSubview(headerView)
        self.view.addSubview(textField)
        self.view.addSubview(doneButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.textField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            self.textField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.textField.heightAnchor.constraint(equalToConstant: 55),
            self.textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.doneButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 22),
            self.doneButton.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            self.doneButton.heightAnchor.constraint(equalToConstant: 55),
            self.doneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapDone() {
        print("DEBUG PRINT:", "didTapDone")
    }
}
