//
//  TutorialToastView.swift
//  TutorialToastView
//
//  Created by Benjamin Hendricks on 11/7/15.
//  Copyright © 2015 coolbnjmn. All rights reserved.
//

import UIKit

public enum TutorialToastViewStyleStyle {
    case Light
    case Dark
    case Custom
}

public class TutorialToastViewStyle {
    
    public var backgroundColor : UIColor
    public var tintColor : UIColor
    public var font : UIFont
    public var padding : CGFloat = 10
    public var closeButtonSize : CGFloat = 20
    
    public required init(backgroundColor: UIColor, tintColor: UIColor, font: UIFont) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.font = font
    }
    
    public convenience init(backgroundColor : UIColor, tintColor : UIColor, font: UIFont, padding: CGFloat?, closeButtonSize: CGFloat?) {
        self.init(backgroundColor: backgroundColor, tintColor: tintColor, font: font)
        if let padding = padding {
            self.padding = padding
        }
        if let closeButtonSize = closeButtonSize {
            self.closeButtonSize = closeButtonSize
        }
    }

    public class func defaultStyle(style : TutorialToastViewStyleStyle) -> TutorialToastViewStyle? {
        switch style {
        case .Light:
            return TutorialToastViewStyle(backgroundColor: UIColor.whiteColor(), tintColor: UIColor.blackColor(), font: UIFont.systemFontOfSize(15))
        case .Dark:
            return TutorialToastViewStyle(backgroundColor: UIColor.darkGrayColor(), tintColor: UIColor.whiteColor(), font: UIFont.systemFontOfSize(15))
        default:
            return nil
        }
    }
    
    public class func customStyle(backgroundColor : UIColor, tintColor : UIColor, font: UIFont) -> TutorialToastViewStyle? {
        return TutorialToastViewStyle(backgroundColor: backgroundColor, tintColor: tintColor, font: font)
    }
    
    public class func customStyleWithPadding(backgroundColor : UIColor, tintColor : UIColor, font: UIFont, padding: CGFloat, closeButtonSize: CGFloat) -> TutorialToastViewStyle? {
        return TutorialToastViewStyle(backgroundColor: backgroundColor, tintColor: tintColor, font: font, padding: padding, closeButtonSize: closeButtonSize)
    }
}

public class TutorialToastView: UIView {
    
    var completion: (()->Void)?
    
    public static func presentTutorialToastView(toastView : TutorialToastView, superView: UIView) {
        toastView.frame.origin.y = toastView.frame.origin.y + toastView.frame.height
        toastView.alpha = 0
        superView.addSubview(toastView)
        UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            toastView.frame.origin.y = toastView.frame.origin.y - toastView.frame.height
            toastView.alpha = 1
            }, completion: {
                finished in
                print("done")
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
    * convenience initializer
    *
    */
    public convenience init(superviewFrame: CGRect, scale: CGFloat, title: String, subtitle: String, defaultStyle: TutorialToastViewStyleStyle, completion: (()->Void)) {
        if let style = TutorialToastViewStyle.defaultStyle(defaultStyle) {
            self.init(superviewFrame: superviewFrame, scale: scale, title: title, subtitle: subtitle, style: style, completion: completion)
        } else {
            let toastFrame = CGRectMake(superviewFrame.origin.x, superviewFrame.height - superviewFrame.height * scale, superviewFrame.width, superviewFrame.height * scale)
            self.init(frame: toastFrame)
            self.completion = completion
            print("Style creation failed")
        }
    }
    
    public convenience init(superviewFrame: CGRect, scale: CGFloat, title: String, subtitle: String, style: TutorialToastViewStyle, completion: (()->Void)) {
        let toastFrame = CGRectMake(superviewFrame.origin.x, superviewFrame.height - superviewFrame.height * scale, superviewFrame.width, superviewFrame.height * scale)
        self.init(frame: toastFrame)
        
        let subtitleLabel = UILabel(frame: CGRectMake(
            toastFrame.origin.x + style.padding,
            style.closeButtonSize + 2 * style.padding,
            toastFrame.width - 2 * style.padding,
            toastFrame.height - style.closeButtonSize - 3 * style.padding))
        subtitleLabel.text = subtitle
        subtitleLabel.textColor = style.tintColor
        subtitleLabel.textAlignment = .Center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = style.font
        
        let titleLabel = UILabel(frame: CGRectMake(
            toastFrame.origin.x + style.padding,
            style.padding,
            toastFrame.width - style.closeButtonSize - 2 * style.padding,
            style.closeButtonSize))
        titleLabel.text = title
        titleLabel.textColor = style.tintColor
        titleLabel.font = style.font
        
        self.backgroundColor = style.backgroundColor
        
        let closeButton = UIButton(frame: CGRectMake(
            toastFrame.width - style.closeButtonSize - style.padding,
            style.padding,
            style.closeButtonSize,
            style.closeButtonSize))
        closeButton.enabled = true
        closeButton.backgroundColor = style.tintColor
        closeButton.addTarget(self, action: "runCompletion:", forControlEvents: .TouchUpInside)
        
        self.addSubview(closeButton)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.completion = completion
    }
    
    func runCompletion(sender: AnyObject) {
        self.completion?()
    }
}

