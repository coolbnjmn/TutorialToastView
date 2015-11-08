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
        self.toastView = TutorialToastView(viewFrame: UIApplication.sharedApplication().windows[0].frame, title: "THIS IS YOUR SEARCH SCREEN", subtitle: "Search by name or industry, filter by follower count, and find who you're looking for", backgroundColor: UIColor.redColor(), completion: {
            self.toastView?.removeFromSuperview()
        })
        
        if let toastView = self.toastView {
            TutorialToastView.presentTutorialToastView(toastView, superView: UIApplication.sharedApplication().windows[0])
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}