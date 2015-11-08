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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.toastView = TutorialToastView(viewFrame: view.frame, title: "THIS IS YOUR SEARCH SCREEN", subtitle: "Search by name or industry, filter by follower count, and find who you're looking for", backgroundColor: UIColor.redColor(), completion: {
        self.toastView = TutorialToastView(superviewFrame: view.frame, scale: (1/3), title: "THIS IS YOUR ALERT TITLE", subtitle: "This is where you can give your users some more details about what is going on", defaultStyle: .Dark, completion: {
            self.toastView?.removeFromSuperview()
        })
        
        if let toastView = self.toastView {
            TutorialToastView.presentTutorialToastView(toastView, superView: view)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
