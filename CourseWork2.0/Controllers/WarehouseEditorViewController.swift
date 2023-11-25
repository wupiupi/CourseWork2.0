//
//  WarehouseEditorViewController.swift
//  CourseWork2.0
//
//  Created by Paul Makey on 23.11.23.
//

import UIKit
import Firebase
import FirebaseStorage

final class WarehouseEditorViewController: UIViewController {
    
    // MARK: - Variables
    var areWeAdding = true
    
    var headerView = AuthHeaderView(
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
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let itemField = CustomTextField(fieldType: .label)
    let amountField = CustomTextField(fieldType: .label)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
        self.view.addSubview(itemField)
        self.view.addSubview(amountField)
        
        self.view.addSubview(doneButton)
        
        self.view.addSubview(stackView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemField.translatesAutoresizingMaskIntoConstraints = false
        amountField.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(itemField)
        stackView.addArrangedSubview(amountField)
        stackView.addArrangedSubview(doneButton)
        
        NSLayoutConstraint.activate(
            [
                self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
                self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.headerView.heightAnchor.constraint(equalToConstant: 222),
                
                self.stackView.topAnchor.constraint(
                    equalTo: self.headerView.bottomAnchor,
                    constant: 20
                ),
                self.stackView.leadingAnchor.constraint(
                    equalTo: self.view.leadingAnchor,
                    constant: 26
                ),
                self.stackView.trailingAnchor.constraint(
                    equalTo: self.view.trailingAnchor,
                    constant: 26
                ),
                self.stackView.widthAnchor.constraint(
                    equalTo: self.view.widthAnchor,
                    multiplier: 0.85
                ),
                
                self.amountField.heightAnchor.constraint(equalToConstant: 55),
                self.itemField.heightAnchor.constraint(equalToConstant: 55)
            ]
        )
    }
    
    private func removeFromDatabase(field: String) {
        
        if field.isEmpty {
            AlertManager.showEmptyFieldAlert(on: self)
            return
        }
        
        let docRef = Firestore.firestore().collection("storage").document("5Gr0T6c6wk2H9WD70Gdd")
        
        let updateData = [
            field: FieldValue.delete()
        ]
        
        docRef.updateData(updateData) { error in
            if let error = error {
                print("Error deleting field: \(error)")
            } else {
                print("Field deleted successfully!")
            }
        }
    }
    
    private func addToDatabase(field: String, value: Int) {
        
        guard !field.isEmpty else  {
            AlertManager.showEmptyFieldAlert(on: self)
            return
        }
        
        let db = Firestore.firestore()
        let documentRef = db.collection("storage").document("5Gr0T6c6wk2H9WD70Gdd")
        
        documentRef.updateData([field: value]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Field added successfully")
            }
        }
    }
    
    // MARK: - Selectors
    @objc private func didTapDone() {
        
        if areWeAdding {
            guard let value = itemField.text,
                  let amount = amountField.text else { return }
            print("Value: \(value)\nAmount: \(amount)")
            addToDatabase(field: value, value: Int(amount) ?? 0)
        } else if !areWeAdding {
            guard let value = itemField.text else { return }
            print("Value: \(value)")
            removeFromDatabase(field: value)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
