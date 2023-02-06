//
//  DraggableView.swift
//  PanGesture_App
//
//  Created by 이치훈 on 2023/02/06.
//

import UIKit

class DraggableView: UIView {
    
    init(){
        super.init(frame: CGRect.zero)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(draggin))
        self.addGestureRecognizer(pan)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func draggin(pan: UIPanGestureRecognizer){
        
        switch pan.state{
        case .began:
            print("began")
            
        case .changed:
            let delta = pan.translation(in: self.superview)
            var myPosition = self.center
            
            myPosition.x += delta.x
            myPosition.y += delta.y
            
            self.center = myPosition
            pan.setTranslation(CGPoint.zero, in: self.superview)
            print(myPosition.y)
            
        case .ended, .cancelled:
            print("cancelled")
            
        default: break
        }
    }
    
    
}
