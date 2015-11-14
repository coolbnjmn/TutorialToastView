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
    
    /**
     * Basic initializer for a toast view style
     *
     *  ::param:: backgroundColor    A UIColor to be used for the background of the toast view
     *  ::param:: tintColor          A UIColor that will style the toast view, such as coloring text and the close button
     *  ::param:: font               A UIFont that will be used for the title and subtitle labels that are displayed in the toast
    */
    public required init(backgroundColor: UIColor, tintColor: UIColor, font: UIFont) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.font = font
    }
    
    /**
     * Convenience initializer for a toast view style
     *
     *  ::param:: backgroundColor    A UIColor to be used for the background of the toast view
     *  ::param:: tintColor          A UIColor that will style the toast view, such as coloring text and the close button
     *  ::param:: font               A UIFont that will be used for the title and subtitle labels that are displayed in the toast
     *  ::param:: padding            (optional) A CGFloat that can override the value of 10 of padding for the text around the sides and the top/bottom. 
     *  ::param:: closeButtonSize    (optional) A CGFloat that can override the size of the close button, and in turn the height of the title label
     */
    public convenience init(backgroundColor : UIColor, tintColor : UIColor, font: UIFont, padding: CGFloat?, closeButtonSize: CGFloat?) {
        self.init(backgroundColor: backgroundColor, tintColor: tintColor, font: font)
        if let padding = padding {
            self.padding = padding
        }
        if let closeButtonSize = closeButtonSize {
            self.closeButtonSize = closeButtonSize
        }
    }

    /**
    *  A class method to retrieve a default style object
    *  
    *  ::param:: style     TutorialToastViewStyleStyle enum value, can be .Dark or .Light, anything else will return nil
    *
    * returns -- a TutorialToastViewStyle with the default values of Light and Dark toasts.
    */
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
    
    /**
    *  A class method to retrieve a custom style object
     *  ::param:: backgroundColor    A UIColor to be used for the background of the toast view
     *  ::param:: tintColor          A UIColor that will style the toast view, such as coloring text and the close button
     *  ::param:: font               A UIFont that will be used for the title and subtitle labels that are displayed in the toast
     * returns -- a TutorialToastViewStyle with the specified parameters.
    */
    public class func customStyle(backgroundColor : UIColor, tintColor : UIColor, font: UIFont) -> TutorialToastViewStyle? {
        return TutorialToastViewStyle(backgroundColor: backgroundColor, tintColor: tintColor, font: font)
    }
    
    /**
     *  A class method to retrieve a custom style object
     *  ::param:: backgroundColor    A UIColor to be used for the background of the toast view
     *  ::param:: tintColor          A UIColor that will style the toast view, such as coloring text and the close button
     *  ::param:: font               A UIFont that will be used for the title and subtitle labels that are displayed in the toast
     *  ::param:: padding            A CGFloat that can override the value of 10 of padding for the text around the sides and the top/bottom.
     *  ::param:: closeButtonSize    A CGFloat that can override the size of the close button, and in turn the height of the title label
     * returns -- a TutorialToastViewStyle with the specified parameters.
     */
    public class func customStyleWithPadding(backgroundColor : UIColor, tintColor : UIColor, font: UIFont, padding: CGFloat, closeButtonSize: CGFloat) -> TutorialToastViewStyle? {
        return TutorialToastViewStyle(backgroundColor: backgroundColor, tintColor: tintColor, font: font, padding: padding, closeButtonSize: closeButtonSize)
    }
}

public class TutorialToastViewAnimationStyle {
    var inAnimationDuration : Double = 0.5
    var inAnimationCurve : UIViewAnimationOptions = .CurveEaseIn
    var outAnimationDuration : Double = 0.5
    var outAnimationCurve : UIViewAnimationOptions = .CurveEaseOut
    var isDynamic : Bool = false
    
    public convenience init(inDuration : Double?, inCurve : UIViewAnimationOptions?, outDuration: Double?, outCurve : UIViewAnimationOptions?) {
        self.init()
        if let inDuration = inDuration {
            inAnimationDuration = inDuration
        }
        if let inCurve = inCurve {
            inAnimationCurve = inCurve
        }
        if let outDuration = outDuration {
            outAnimationDuration = outDuration
        }
        if let outCurve = outCurve {
            outAnimationCurve = outCurve
        }
    }
    
    public convenience init(isDynamic: Bool) {
        self.init()
        self.isDynamic = isDynamic
    }
    
    public class func defaultAnimationStyle() -> TutorialToastViewAnimationStyle {
        return TutorialToastViewAnimationStyle()
    }
    
    public class func customAnimationStyle(inDuration : Double?, inCurve : UIViewAnimationOptions?, outDuration: Double?, outCurve : UIViewAnimationOptions?) -> TutorialToastViewAnimationStyle {
        return TutorialToastViewAnimationStyle(inDuration: inDuration, inCurve: inCurve, outDuration: outDuration, outCurve: outCurve)
    }
    
    public class func dynamicAnimationStyle() -> TutorialToastViewAnimationStyle {
        return TutorialToastViewAnimationStyle(isDynamic: true)
    }
}

public class TutorialToastView: UIView {
    
    var completion: (()->Void)?
    var animationStyle : TutorialToastViewAnimationStyle?
    var animator : UIDynamicAnimator?
    
    static let kTransitionGestureVelocityThreshold : CGFloat = 50
    static let kTransitionGestureLocationThreshold : CGFloat = 100
    var initialCenter : CGPoint?
    /**
    * A static method used to present a toast view within a given super view. 
    * We animate the view in, using a 2 second animation
    *
    * ::param::       toastView    TutorialToastView which you want to present
    * ::param::       superView    A UIView in which to present the TutorialToastView
    *
    */
    public static func presentTutorialToastView(toastView : TutorialToastView, superView: UIView) {
        superView.addSubview(toastView)
        var anStyle : TutorialToastViewAnimationStyle
        if let animationStyle = toastView.animationStyle {
            anStyle = animationStyle
        } else {
            anStyle = TutorialToastViewAnimationStyle.defaultAnimationStyle()
        }
        
        toastView.initialCenter = toastView.center
        toastView.frame.origin.y = toastView.frame.origin.y + toastView.frame.height

        if !anStyle.isDynamic {
            toastView.alpha = 0
            UIView.animateWithDuration(anStyle.inAnimationDuration, delay: 0, options: anStyle.inAnimationCurve, animations: {
                toastView.frame.origin.y = toastView.frame.origin.y - toastView.frame.height
                toastView.alpha = 1
                }, completion: {
                    finished in
            })
        } else {
            let snapBehavior : UISnapBehavior = UISnapBehavior(item: toastView, snapToPoint: CGPointMake(toastView.center.x, toastView.center.y - toastView.frame.height))
            snapBehavior.damping = 0.65
            
            let bounceBehavior : UIDynamicItemBehavior = UIDynamicItemBehavior(items: [])
            bounceBehavior.elasticity = 0.6
            
            
            toastView.animator = UIDynamicAnimator(referenceView: superView)
            toastView.animator?.addBehavior(snapBehavior)
            toastView.animator?.addBehavior(bounceBehavior)
            
            
        }

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
    * A convenience initializer for a TutorialToastView
    * 
    * ::param:: superviewFrame     CGRect The frame in which to embed this tutorial toast view
    * ::param:: scale              CGFloat A value between 0 and 1, a portion of the superview's height in which to display the toast view
    * ::param:: title              String A string that will be displayed at the top of the tutorial toast view, should be about 1 line of text (~40-60 characters)
    * ::param:: subtitle           String A string that will be displayed in the body of the toast. Can be multiple lines in length
    * ::param:: defaultStyle       TutorialToastViewStyleStyle  A enum value, can be .Light or .Dark
    * ::param:: completion         ()->Void A completion which can handle anything you need to happen when the toast view disappears.
    *
    */
    public convenience init(superviewFrame: CGRect, scale: CGFloat, title: String, subtitle: String, defaultStyle: TutorialToastViewStyleStyle, animationStyle: TutorialToastViewAnimationStyle?, completion: (()->Void)) {
        if let style = TutorialToastViewStyle.defaultStyle(defaultStyle) {
            self.init(superviewFrame: superviewFrame, scale: scale, title: title, subtitle: subtitle, style: style, animationStyle: animationStyle, completion: completion)
        } else {
            let toastFrame = CGRectMake(superviewFrame.origin.x, superviewFrame.height - superviewFrame.height * scale, superviewFrame.width, superviewFrame.height * scale)
            self.init(frame: toastFrame)
            self.completion = completion
            print("Style creation failed")
        }
    }
    
    /**
     * A convenience initializer for a TutorialToastView
     *
     * ::param:: superviewFrame     CGRect The frame in which to embed this tutorial toast view
     * ::param:: scale              CGFloat A value between 0 and 1, a portion of the superview's height in which to display the toast view
     * ::param:: title              String A string that will be displayed at the top of the tutorial toast view, should be about 1 line of text (~40-60 characters)
     * ::param:: subtitle           String A string that will be displayed in the body of the toast. Can be multiple lines in length
     * ::param:: style              TutorialToastViewStyle  A custom style, should be initialized before this method call
     * ::param:: completion         ()->Void A completion which can handle anything you need to happen when the toast view disappears.
     *
     */
    public convenience init(superviewFrame: CGRect, scale: CGFloat, title: String, subtitle: String, style: TutorialToastViewStyle, animationStyle: TutorialToastViewAnimationStyle?, completion: (()->Void)) {
        var theScale = scale
        if theScale > 1 || theScale < 0 {
            theScale = (1/3)
        }
        
        let toastFrame = CGRectMake(superviewFrame.origin.x, superviewFrame.height - superviewFrame.height * theScale, superviewFrame.width, superviewFrame.height * theScale)
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
        
        if let animationStyle = animationStyle {
            self.animationStyle = animationStyle
        }
        
        let tapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "runCompletion:")
        self.addGestureRecognizer(tapGestureRecognizer)
        
        let panGestureRecognizer : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "animateView:")
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    func animateView(sender : UIGestureRecognizer) {
        if let sender = sender as? UIPanGestureRecognizer {
            if sender.state == UIGestureRecognizerState.Began {
                layer.removeAllAnimations()
                animator?.removeAllBehaviors()
            } else if sender.state == UIGestureRecognizerState.Changed {
                let translation : CGPoint = sender.translationInView(sender.view)
                
                if var initialCenter = self.initialCenter {
                    initialCenter.x += translation.x
                    initialCenter.y += translation.y
                    
                    self.center = initialCenter
                }
            } else if sender.state == UIGestureRecognizerState.Ended {
                let location : CGPoint = sender.locationInView(sender.view)
                let velocity : CGPoint = sender.velocityInView(sender.view)
                
                var shouldFinish : Bool = false
                
                if(abs(velocity.y) > TutorialToastView.kTransitionGestureVelocityThreshold) {
                    shouldFinish = velocity.y > 0
                } else {
                    shouldFinish = location.y > TutorialToastView.kTransitionGestureLocationThreshold
                }
                
                if shouldFinish {
                    runCompletion(sender)
                } else {
                    if let initialCenter = initialCenter {
                        let snapBehavior : UISnapBehavior = UISnapBehavior(item: self, snapToPoint: initialCenter)
                        snapBehavior.damping = 0.65
                        animator?.removeAllBehaviors()
                        animator?.addBehavior(snapBehavior)
                    }
                }
            }
        }
    }
    
    func runCompletion(sender: AnyObject) {
        var anStyle : TutorialToastViewAnimationStyle
        if let animationStyle = animationStyle {
            anStyle = animationStyle
        } else {
            anStyle = TutorialToastViewAnimationStyle.defaultAnimationStyle()
        }
        
        if !anStyle.isDynamic {
            UIView.animateWithDuration(anStyle.outAnimationDuration, delay: 0, options: anStyle.outAnimationCurve, animations: {
                self.frame.origin.y = self.frame.origin.y + self.frame.height
                self.alpha = 0
                }, completion: {
                    finished in
                    self.removeFromSuperview()
                    self.completion?()
            })
        } else {
            let snapBehavior : UISnapBehavior = UISnapBehavior(item: self, snapToPoint: CGPointMake(self.center.x, self.center.y + self.frame.height))
            snapBehavior.damping = 0.65
            
            if let _ = self.animator {
                self.animator?.removeAllBehaviors()
                self.animator?.addBehavior(snapBehavior)
            }
            
            UIView.animateWithDuration(0.1, animations: {
                self.alpha = 0
                }, completion: {
                    finished in
                    self.removeFromSuperview()
                    self.completion?()
            })
        }
       
    }
}
