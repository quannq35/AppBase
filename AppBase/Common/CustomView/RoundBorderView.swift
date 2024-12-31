//
//  RoundBorderView.swift
//  AppBase
//
//  Created by Quân Nguyễn on 31/12/24.
//

import Foundation
import UIKit

@IBDesignable
open class RoundBorderView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }

    @IBInspectable var shadowColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }

    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var shadowBlur: CGFloat = 2 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var shadowOffsetX: CGFloat = 2 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var shadowOffsetY: CGFloat = 2 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var enableShadow: Bool = false {
        didSet {
            updateView()
        }
    }

    @IBInspectable var enableBorderColor: Bool = false {
        didSet {
            updateView()
        }
    }

    @IBInspectable public var defaultColor: UIColor?
    @IBInspectable public var selectedColor: UIColor?

    func updateView() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        if enableShadow {
            makeShadow(blur: shadowBlur,
                       color: shadowColor.cgColor,
                       opacity: shadowOpacity,
                       shadowOffsetX: shadowOffsetX,
                       shadowOffsetY: shadowOffsetY)
        }
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if selectedColor != nil {
            DispatchQueue.main.async {
                self.backgroundColor = self.selectedColor
            }
        }
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if defaultColor != nil {
            DispatchQueue.main.async {
                self.backgroundColor = self.defaultColor
            }
        }
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if defaultColor != nil {
            DispatchQueue.main.async {
                self.backgroundColor = self.defaultColor
            }
        }
    }
}
