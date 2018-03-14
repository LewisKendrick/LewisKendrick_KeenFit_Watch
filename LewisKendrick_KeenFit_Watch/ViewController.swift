//
//  ViewController.swift
//  LewisKendrick_KeenFit_Watch
//
//  Created by kendrick lewis on 3/12/18.
//  Copyright © 2018 kendrick lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startClicked(_ sender: UIButton)
    {
        performSegue(withIdentifier: "toDetails", sender: nil)
    }
    
}

