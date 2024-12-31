//
//  UIView+Ext.swift
//  AppBase
//
//  Created by Quân Nguyễn on 31/12/24.
//

import Foundation
import UIKit

public extension UIView {
    /// create border for view with border width and color
    /// - Parameters:
    ///   - borderWidth: border width
    ///   - borderColor: border color
    func makeBorder(_ borderWidth: CGFloat, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }

    /// create corner radius for view
    /// - Parameter radius: corner radius
    func makeRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }

    /// create view shadow
    func makeShadow(blur: CGFloat, color: CGColor?, opacity: Float, shadowOffsetX: CGFloat, shadowOffsetY: CGFloat) {
        layer.shadowRadius = blur
        layer.shadowOffset = CGSize(width: shadowOffsetX, height: shadowOffsetY)
        layer.shadowOpacity = opacity
        layer.shadowColor = color ?? UIColor.black.cgColor
        layer.masksToBounds = false
    }

    /// create gradient background for view
    /// - Parameters:
    ///   - colorTop: top color
    ///   - colorBottom: bottom color
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }

    /// Create separator view
    /// - Parameters:
    ///   - color: separator color
    ///   - separatorHeight: separator height
    func addBottomSeparatorView(color: UIColor, separatorHeight: Double) {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(separatorView)
        separatorView.backgroundColor = color
        separatorView.heightAnchor.constraint(equalToConstant: separatorHeight).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder!.next
        }
        return nil
    }
    
    func roundCornerView(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = CGAffineTransformRotate(self.transform, radians);
        self.transform = rotation
    }
    
    func rotate360(duration: CFTimeInterval = 1) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func addTopShadow(shadowColor : UIColor, shadowOpacity : Float, shadowRadius : Float, offset:CGSize){
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.clipsToBounds = false
    }
}
