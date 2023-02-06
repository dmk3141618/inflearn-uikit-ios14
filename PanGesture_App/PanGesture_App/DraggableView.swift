//
//  DraggableView.swift
//  PanGesture_App
//
//  Created by 이치훈 on 2023/02/06.
//

import UIKit

class DraggableView: UIView {
    
    var dragType = DragType.none
    
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
            
            if dragType == .x {
                myPosition.x += delta.x
            }else if dragType == .y {
                myPosition.y += delta.y
            }else{
                myPosition.x += delta.x
                myPosition.y += delta.y
            }
            
            self.center = myPosition
            pan.setTranslation(CGPoint.zero, in: self.superview)
            
            print("x = \(round(myPosition.x*100)/100), y = \(round(myPosition.y*100)/100)")
            
        case .ended, .cancelled:
            print("cancelled")
            if self.frame.minX < 0 {
                self.frame.origin.x = 0
            }
            if let hasSuperView = self.superview {
                if self.frame.maxX > hasSuperView.frame.maxX {
                    self.frame.origin.x = hasSuperView.frame.maxX - self.bounds.width
                }
            }
            if self.frame.minY < 0 {
                self.frame.origin.y = 0
            }
            if let hasSuperView = self.superview {
                if self.frame.maxY > hasSuperView.frame.maxY {
                    self.frame.origin.y = hasSuperView.frame.maxY - self.bounds.height
                }
            }
        default: break
        }
    }
    
    
}
