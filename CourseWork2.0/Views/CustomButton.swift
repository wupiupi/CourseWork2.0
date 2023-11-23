//
//  CustomButton.swift
//  CourseWork2.0
//
//  Created by Paul Makey on 22.11.23.
//

import UIKit

class CustomButton: UIButton {

    enum FontSize {
        case big
        case medium
        case small
    }
    
    init(title: String, hasBackground: Bool, fontSize: FontSize, textColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        self.backgroundColor = hasBackground ? .systemGray4 : .clear
        
        self.setTitleColor(textColor, for: .normal )
        
        switch fontSize {
            case .big:
                self.titleLabel?.font = . systemFont(ofSize: 22, weight: .bold)
            case .medium:
                self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
            case .small:
                self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
