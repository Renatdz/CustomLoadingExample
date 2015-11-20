//
//  ViewController.swift
//  LoadingCustomExample
//
//  Created by Renato Mendes on 20/11/15.
//  Copyright © 2015 Renato Mendes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var loading : CustomLoading?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loading = CustomLoading(red: 0, green: 110.0, blue: 201.0)
    }

    @IBAction func start(sender: AnyObject) {
        self.loading?.start()
    }
    
    @IBAction func stop(sender: AnyObject) {
        self.loading?.stop()
    }
}

