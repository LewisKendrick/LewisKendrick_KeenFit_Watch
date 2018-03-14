//
//  WaterInterfaceController.swift
//  LewisKendrick_KeenFit_Watch WatchKit Extension
//
//  Created by kendrick lewis on 3/13/18.
//  Copyright © 2018 kendrick lewis. All rights reserved.
//

import UIKit
import WatchKit

class WaterInterfaceController: WKInterfaceController
{
    @IBOutlet var countDisplay: WKInterfaceLabel!
    var count = 0
    
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
        count = 0
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func subtractCount()
    {
        if count > 0
        {
            count = count - 1
            countDisplay.setText(String(count))
        }
        
    }
    
    @IBAction func addCount()
    {
        if count >= 0
        {
            count = count + 1
            countDisplay.setText(String(count))
        }
    }
    
}
