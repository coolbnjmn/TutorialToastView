//
//  ViewController.swift
//  TutorialToastViewDemo
//
//  Created by Benjamin Hendricks on 11/8/15.
//  Copyright © 2015 coolbnjmn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var toastView : TutorialToastView?
    
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var darkButton: UIButton!
    @IBOutlet weak var customButton: UIButton!
    
    @IBOutlet weak var backgroundColorPicker: UISegmentedControl!
    
    @IBOutlet weak var tintColorPicker: UISegmentedControl!
    
    @IBOutlet weak var fontPicker: UISegmentedControl!
    
    @IBOutlet weak var paddingSlider: UISlider!
    
    @IBOutlet weak var closeButtonSizeSlider: UISlider!
    var isPresenting : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func colorForButton(pickerIndex: Int) -> UIColor {
        switch pickerIndex {
        case 0:
            return UIColor.blueColor()  
        case 1:
            return UIColor.redColor()
        case 2:
            return UIColor.yellowColor()
        case 3:
            return UIColor.orangeColor()
        default:
            return UIColor.clearColor()
        }
    }
    
    private func fontForButton(pickerIndex: Int) -> UIFont? {
        switch pickerIndex {
        case 0:
            return UIFont(name: "TimesNewRomanPSMT", size: 15)
        case 1:
            return UIFont(name: "HelveticaNeue", size: 15)
        case 2:
            return UIFont(name: "MarkerFelt-Thin", size: 15)
        case 3:
            return UIFont(name: "Futura-CondensedMedium", size: 15)
        default:
            return UIFont.systemFontOfSize(15)
        }
    }
    @IBAction func customButtonPressed(sender: AnyObject) {
        if !isPresenting {
            let style = TutorialToastViewStyle(backgroundColor: colorForButton(backgroundColorPicker.selectedSegmentIndex), tintColor: colorForButton(tintColorPicker.selectedSegmentIndex), font: fontForButton(fontPicker.selectedSegmentIndex)!, padding: CGFloat(paddingSlider.value), closeButtonSize: CGFloat(closeButtonSizeSlider.value))
            self.toastView = TutorialToastView(superviewFrame: view.frame, scale: (1/3), title: "THIS IS YOUR ALERT TITLE", subtitle: "This is where you can give your users some more details about what is going on", style: style, animationStyle: nil, completion: {
                self.isPresenting = false
            })
            
            if let toastView = self.toastView {
                isPresenting = true
                TutorialToastView.presentTutorialToastView(toastView, superView: view)
            }
        }
    }
    
    @IBAction func darkButtonPressed(sender: AnyObject) {
        if !isPresenting {
            self.toastView = TutorialToastView(superviewFrame: view.frame, scale: (1/3), title: "THIS IS YOUR ALERT TITLE", subtitle: "This is where you can give your users some more details about what is going on", defaultStyle: .Dark, animationStyle: nil, completion: {
                self.toastView?.removeFromSuperview()
                self.isPresenting = false
            })
            
            if let toastView = self.toastView {
                isPresenting = true
                TutorialToastView.presentTutorialToastView(toastView, superView: view)
            }
        }
    }
    @IBAction func lightButtonPressed(sender: AnyObject) {
        if !isPresenting {
            self.toastView = TutorialToastView(superviewFrame: view.frame, scale: (1/3), title: "THIS IS YOUR ALERT TITLE", subtitle: "This is where you can give your users some more details about what is going on", defaultStyle: .Light, animationStyle: nil, completion: {
                self.toastView?.removeFromSuperview()
                self.isPresenting = false
            })
            
            if let toastView = self.toastView {
                isPresenting = true
                TutorialToastView.presentTutorialToastView(toastView, superView: view)
            }
        }
    }
    
    
    
}
