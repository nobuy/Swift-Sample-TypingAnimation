//
//  ViewController.swift
//  Swift-Sample-TypingAnimation
//
//  Created by A10 Lab Inc. 003 on 2019/03/08.
//  Copyright © 2019 A10 Lab Inc. nobuy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Typing Animation"
        // Do any additional setup after loading the view, typically from a nib.
        let dots = TypingAnimationView(appearance: TypingAnimationAppearance())
        dots.center = view.center
        view.addSubview(dots)
    }


}

