//
//  BadgedBarButtonItem.swift
//  BadgedBarButtonItem
//
//  Created by Eric Miller on 6/2/14.
//  Copyright (c) 2014 Tiny Zepplin. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore

@available(*, deprecated: 3.1, message: "ENMBadgedBarButtonItem will soon become unavailable. Please use the updated BadgedBarButtonItem class name")
public typealias ENMBadgedBarButtonItem = BadgedBarButtonItem

public class BadgedBarButtonItem: UIBarButtonItem {
    
    var badgeLabel: UILabel = UILabel()
    @IBInspectable public var badgeValue: Int  = 0 {
        didSet {
            guard !shouldBadgeHide(badgeValue) else {
                if (badgeLabel.superview != nil) {
                    removeBadge()
                }
                return
            }
            
            if (badgeLabel.superview != nil) {
                updateBadgeValue(animated: shouldAnimateBadge)
            } else {
                badgeLabel = self.createBadgeLabel()
                updateBadgeProperties()
                customView?.addSubview(badgeLabel)
                
                // Pull the setting of the value and layer border radius off onto the next event loop.
                DispatchQueue.main.async() { () -> Void in
                    self.badgeLabel.text = self.badgeValueString
                    self.updateBadgeFrame()
                }
            }
        }
    }
    
    fileprivate var _badgeValueString: String?
    fileprivate var badgeValueString: String {
        get {
            if let customString = _badgeValueString {
                return customString
            }
            
            return "\(badgeValue)"
        }
        set {
            _badgeValueString = newValue
        }
    }
    
    /**
     When the badgeValue is set to `0`, this flag will be checked to determine if the 
     badge should be hidden.  Defaults to true.
    */
    public var shouldHideBadgeAtZero: Bool = true
    
    /**
     Flag indicating if the `badgeValue` should be animated when the value is changed.
     Defaults to true.
    */
    public var shouldAnimateBadge: Bool = true
    
    /**
     A collection of properties that define the layout and behavior of the badge.
     Accessable after initialization if run-time updates are required.
    */
    public var badgeProperties: BadgeProperties
    
    public init(customView: UIView, value: Int, badgeProperties: BadgeProperties = BadgeProperties.default) {
        self.badgeProperties = badgeProperties
        super.init()
        
        badgeValue = value
        self.customView = customView
        
        commonInit()
    }
    
    public init(startingBadgeValue: Int,
                frame: CGRect,
                title: String? = nil,
                image: UIImage?,
                badgeProperties: BadgeProperties = BadgeProperties.default) {
        
        self.badgeProperties = badgeProperties
        super.init()
        
        self.badgeValue = startingBadgeValue
        performStoryboardInitalizationSetup(with: frame, title: title, image: image)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.badgeProperties = BadgeProperties.default
        super.init(coder: aDecoder)
        
        var buttonFrame: CGRect = CGRect.zero
        if let image = self.image {
            buttonFrame = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
        } else if let title = self.title {
            let lbl = UILabel()
            lbl.text = title
            let textSize = lbl.sizeThatFits(CGSize(width: 100.0, height: 100.0))
            buttonFrame = CGRect(x: 0.0, y: 0.0, width: textSize.width + 2.0, height: textSize.height)
        }
        
        
        performStoryboardInitalizationSetup(with: buttonFrame, title: self.title, image: self.image)
        commonInit()
    }
    
    private func performStoryboardInitalizationSetup(with frame: CGRect, title: String? = nil, image: UIImage?) {
        let btn = createInternalButton(frame: frame, title: title, image: image)
        self.customView = btn
        btn.addTarget(self, action: #selector(internalButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func commonInit() {
        badgeLabel.font = badgeProperties.font
        badgeLabel.textColor = badgeProperties.textColor
        badgeLabel.backgroundColor = badgeProperties.backgroundColor
    }
    
    /**
     Creates the internal UIButton to be used as the custom view of the UIBarButtonItem.
     
     - Note: Subclassable for further customization.
     
     - Parameter frame: The frame of the final BadgedBarButtonItem
     - Parameter title: The title of the BadgedBarButtonItem. Optional. Defaults to nil.
     - Parameter image: The image of the BadgedBarButtonItem. Optional.
    */
    open func createInternalButton(frame: CGRect,
                                   title: String? = nil,
                                   image: UIImage?) -> UIButton {
        
        let btn = UIButton(type: .custom)
        btn.setImage(image, for: UIControlState())
        btn.setTitle(title, for: UIControlState())
        btn.setTitleColor(UIColor.black, for: UIControlState())
        btn.frame = frame
        
        return btn
    }
}

// MARK: - Public Functions
public extension BadgedBarButtonItem {
    
    /**
     Programmatically adds a target-action pair to the BadgedBarButtonItem
    */
    public func addTarget(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
}


// MARK: - Private Functions
fileprivate extension BadgedBarButtonItem {
    
    func updateBadgeValue(animated: Bool) {
        if (animated && (badgeLabel.text != badgeValueString)) {
            let animation: CABasicAnimation = CABasicAnimation()
            animation.keyPath = "transform.scale"
            animation.fromValue = 1.5
            animation.toValue = 1
            animation.duration = 0.2
            animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 1.3, 1.0, 1.0)
            badgeLabel.layer.add(animation, forKey: "bounceAnimation")
        }
        
        badgeLabel.text = badgeValueString;
        
        let duration: Double = animated ? 0.2 : 0.0
        UIView.animate(withDuration: duration) {
            self.updateBadgeFrame()
        }
    }
    
    func updateBadgeFrame() {
        let expectedLabelSize: CGSize = badgeExpectedSize()
        var minHeight = expectedLabelSize.height
        
        minHeight = (minHeight < badgeProperties.minimumWidth) ? badgeProperties.minimumWidth : expectedLabelSize.height
        var minWidth = expectedLabelSize.width
        let horizontalPadding = badgeProperties.horizontalPadding
        
        minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width
        
        let nFrame = CGRect(
            x: badgeProperties.originalFrame.origin.x,
            y: badgeProperties.originalFrame.origin.y,
            width: minWidth + horizontalPadding,
            height: minHeight + horizontalPadding
        )
        
        UIView.animate(withDuration: 0.2) {
            self.badgeLabel.frame = nFrame
        }
        
        self.badgeLabel.layer.cornerRadius = (minHeight + horizontalPadding) / 2
    }
    
    func removeBadge() {
        let duration = shouldAnimateBadge ? 0.08 : 0.0
        
        let currentTransform = badgeLabel.layer.transform
        let tf = CATransform3DMakeScale(0.001, 0.001, 1.0)
        badgeLabel.layer.transform = tf
        let scaleAnimation = CABasicAnimation()
        scaleAnimation.fromValue = currentTransform
        scaleAnimation.duration = duration
        scaleAnimation.isRemovedOnCompletion = true
        badgeLabel.layer.add(scaleAnimation, forKey: "transform")
        
        badgeLabel.layer.opacity = 0.0
        let opacityAnimation = CABasicAnimation()
        opacityAnimation.fromValue = 1.0
        opacityAnimation.duration = duration
        opacityAnimation.isRemovedOnCompletion = true
        opacityAnimation.delegate = self
        badgeLabel.layer.add(opacityAnimation, forKey: "opacity")
    }
    
    func createBadgeLabel() -> UILabel {
        let frame = CGRect(
            x: badgeProperties.originalFrame.origin.x,
            y: badgeProperties.originalFrame.origin.y,
            width: badgeProperties.originalFrame.width,
            height: badgeProperties.originalFrame.height
        )
        let label = UILabel(frame: frame)
        label.textColor = badgeProperties.textColor
        label.font = badgeProperties.font
        label.backgroundColor = badgeProperties.backgroundColor
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = frame.size.width / 2
        label.clipsToBounds = true
        
        return label
    }
    
    func badgeExpectedSize() -> CGSize {
        let frameLabel: UILabel = self.duplicateLabel(badgeLabel)
        frameLabel.sizeToFit()
        let expectedLabelSize: CGSize = frameLabel.frame.size
        
        return expectedLabelSize
    }
    
    func duplicateLabel(_ labelToCopy: UILabel) -> UILabel {
        let dupLabel = UILabel(frame: labelToCopy.frame)
        dupLabel.text = labelToCopy.text
        dupLabel.font = labelToCopy.font
        
        return dupLabel
    }
    
    func shouldBadgeHide(_ value: Int) -> Bool {
        return (value == 0) && shouldHideBadgeAtZero
    }
    
    func updateBadgeProperties() {
        if let customView = self.customView {
            badgeProperties.originalFrame.origin.x = customView.frame.size.width - badgeLabel.frame.size.width/2
        }
    }
    
    @objc func internalButtonTapped(_ sender: UIButton) {
        guard let action = self.action, let target = self.target else {
            preconditionFailure("Developer Error: The BadgedBarButtonItem requires a target-action pair")
        }
    
        UIApplication.shared.sendAction(action, to: target, from: self, for: nil)
    }
}

extension BadgedBarButtonItem: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.badgeLabel.removeFromSuperview()
        }
    }
}
