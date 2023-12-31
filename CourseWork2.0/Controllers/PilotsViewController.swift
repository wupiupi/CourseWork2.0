//
//  WarehouseViewController.swift
//  CourseWork2.0
//
//  Created by Paul Makey on 23.11.23.
//

import UIKit
import Firebase
import Foundation

final class PilotsViewController: UIViewController {
    
    // MARK: - UI Components
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let addButton = CustomButton(
        title: "Add new",
        hasBackground: true,
        fontSize: .medium,
        textColor: .label
    )
    
    private let removeButton = CustomButton(
        title: "Remove",
        hasBackground: true,
        fontSize: .medium,
        textColor: .label
    )
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        addButton.addTarget(
            self,
            action: #selector(didTapAdd),
            for: .touchUpInside
        )
        
        removeButton.addTarget(
            self,
            action: #selector(didTapRemove),
            for: .touchUpInside
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchStorage { dataArray in
            self.clearStackView() // Remove existing labels before adding new ones
            
            for dictionary in dataArray {
                let sortedDictionary = dictionary.sorted { $0.key.localizedCaseInsensitiveCompare($1.key) == .orderedAscending }
                
                for (key, value) in sortedDictionary {
                    
                    print("ФИО: \(key) Звание: \(value)")
                    
                    let label = self.getLabel()
                    label.text = "\(key) - \(value)"
                    self.stackView.addArrangedSubview(label)
                }
            }
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        self.view.backgroundColor = .systemGray6
        
        self.view.addSubview(stackView)
        self.view.addSubview(addButton)
        self.view.addSubview(removeButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.stackView.heightAnchor.constraint(equalToConstant: 500),
            
            self.addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 22),
            self.addButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            self.addButton.heightAnchor.constraint(equalToConstant: 55),
            self.addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.removeButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 22),
            self.removeButton.centerXAnchor.constraint(equalTo: addButton.centerXAnchor),
            self.removeButton.heightAnchor.constraint(equalToConstant: 55),
            self.removeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    // MARK: - Methods
    private func clearStackView() {
        stackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func getLabel() -> UILabel {
            let label = UILabel()
            label.textColor = .label
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.text = "Error"
            return label
    }
    
    public func fetchStorage(completion: @escaping ([[String: Any]]) -> Void) {
        let db = Firestore.firestore()
        let pilotsCollectionRef = db.collection("pilots")
        
        var dataArray: [[String: Any]] = []
        
        pilotsCollectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion(dataArray) // Call completion with empty array
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                completion(dataArray) // Call completion with empty array
                return
            }
            
            for document in documents {
                let data = document.data()
                dataArray.append(data)
            }
            completion(dataArray) // Call completion with populated array
        }
    }
    // MARK: - Selectors
    @objc private func didTapAdd() {
        let vc = PilotsEditorViewController()
        vc.itemField.placeholder = "Enter pilot name"
        vc.amountField.placeholder = "Enter pilot rank"
        vc.headerView = AuthHeaderView(title: "Attention", subtitle: "You want to add item to a list.")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapRemove() {
        let vc = PilotsEditorViewController()
        vc.itemField.placeholder = "Enter MANUALLY pilot to delete"
        vc.areWeAdding = false
        vc.amountField.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

