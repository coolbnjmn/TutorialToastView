//
//  TutorialToastView.swift
//  TutorialToastView
//
//  Created by Benjamin Hendricks on 11/7/15.
//  Copyright © 2015 coolbnjmn. All rights reserved.
//

import UIKit

class TutorialToastView: UIView {
    
    static let closeButtonSize : CGFloat = 20
    static let standardPadding : CGFloat = 10
    var completion: (()->Void)?
    
    static func presentTutorialToastView(toastView : TutorialToastView, superView: UIView) {
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(viewFrame: CGRect, title: String, subtitle: String, backgroundColor: UIColor, completion: (()->Void)) {
        let toastFrame = CGRectMake(viewFrame.origin.x, viewFrame.height - viewFrame.height/3, viewFrame.width, viewFrame.height/3)
        self.init(frame: toastFrame)
        let titleLabel = UILabel(frame: CGRectMake(
            toastFrame.origin.x + TutorialToastView.standardPadding,
            TutorialToastView.closeButtonSize + 2 * TutorialToastView.standardPadding,
            toastFrame.width - 2 * TutorialToastView.standardPadding,
            toastFrame.height - TutorialToastView.closeButtonSize - 3 * TutorialToastView.standardPadding))
        titleLabel.text = subtitle
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 0
        
        let mainTitleLabel = UILabel(frame: CGRectMake(
            toastFrame.origin.x + TutorialToastView.standardPadding,
            TutorialToastView.standardPadding,
            toastFrame.width - TutorialToastView.closeButtonSize - 2 * TutorialToastView.standardPadding,
            TutorialToastView.closeButtonSize
            ))
        mainTitleLabel.text = title
        mainTitleLabel.textColor = UIColor.whiteColor()
        
        self.backgroundColor = backgroundColor
        let closeButton = UIButton(frame: CGRectMake(toastFrame.width - TutorialToastView.closeButtonSize - TutorialToastView.standardPadding, TutorialToastView.standardPadding, TutorialToastView.closeButtonSize, TutorialToastView.closeButtonSize))
        closeButton.enabled = true
        closeButton.addTarget(self, action: "runCompletion:", forControlEvents: .TouchUpInside)
        closeButton.backgroundColor = UIColor.greenColor()
        self.addSubview(closeButton)
        self.addSubview(titleLabel)
        self.addSubview(mainTitleLabel)
        self.completion = completion
        
    }
    
    func runCompletion(sender: AnyObject) {
        self.completion?()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}

