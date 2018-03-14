//
//  rowController.swift
//  LewisKendrick_KeenFit_Watch WatchKit Extension
//
//  Created by kendrick lewis on 3/13/18.
//  Copyright © 2018 kendrick lewis. All rights reserved.
//

import UIKit
import WatchKit
import Foundation

class WorkoutRowController: NSObject
{
    @IBOutlet var rowTitle: WKInterfaceLabel!
    
    @IBOutlet var rowDetail: WKInterfaceLabel!
    
    @IBOutlet var rowGroup: WKInterfaceGroup!
}
