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
    
    //MARK: -Properties
    
    var isUp = RotateType.down {
        didSet{
            self.changeDesign()
        }
    }
    
    var selectTypeCallback: ((RotateType) -> Void)?
    //MARK: -Init
    
    init() {
        super.init(frame: .zero)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
        //fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -ButtonOption
    
    private func configure() {
        self.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
    }
    
    @objc private func selectButton() {
        if isUp == .up {
            isUp = .down
        }else{
            isUp = .up
        }
        
        self.selectTypeCallback?(isUp)
    }
    
    private func changeDesign() {
        
        UIView.animate(withDuration: 0.25) {
            if self.isUp == .up {
                self.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.3)
            }else{
                self.imageView?.transform = .identity
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            }
            
        }
    }
    
}
