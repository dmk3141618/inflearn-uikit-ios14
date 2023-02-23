//
//  RotateButton.swift
//  CustomButton
//
//  Created by 이치훈 on 2023/02/24.
//

import UIKit

enum RotateType {
    case up
    case down
}

class RotateButton: UIButton {
    
    var isUp = RotateType.down {
        didSet{
            self.changeDesign()
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
    }
    
    @objc private func selectButton() {
        if isUp == .up {
            isUp = .down
        }else{
            isUp = .up
        }
    }
    
    private func changeDesign() {
        if isUp == .down {
            self.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.3)
        }else{
            self.imageView?.transform = .identity
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
        }
    }
    
}
