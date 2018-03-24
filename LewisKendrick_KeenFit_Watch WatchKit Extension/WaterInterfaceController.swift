//
//  WaterInterfaceController.swift
//  LewisKendrick_KeenFit_Watch WatchKit Extension
//
//  Created by kendrick lewis on 3/13/18.
//  Copyright © 2018 kendrick lewis. All rights reserved.
//

import UIKit
import WatchKit
import WatchConnectivity

class WaterInterfaceController: WKInterfaceController, WCSessionDelegate
{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
    {
        //empty : no use for this
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any])
    {
        //unserilaze and decode any data we have
       // var replyValues = Dictionary<String, AnyObject>()
        
        let loadedData = message["workoutData"]
        
        let loadedWorkout = NSKeyedUnarchiver.unarchiveObject(with: loadedData as! Data) as? InfoClass
        
        let workoutData = loadedWorkout!
        
        wCount = workoutData.waterCount!
        
        setDisplay()
        
    
        
    }
    
    @IBOutlet var countDisplay: WKInterfaceLabel!
    var count = 0
    
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
        // Configure interface objects here.
        setDisplay()
    }
    
    func setDisplay()
    {
        countDisplay.setText(String(wCount))
    }
    
    override func willActivate()
    {
        // checking the session
        if(WCSession.isSupported())
        {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
        
        
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        count = wCount
        countDisplay.setText(String(wCount))
        
//        if(WCSession.default.isReachable)
//        {
//            //this is calling to the phone asking for data
//            let message = ["getWorkoutData" : [:]]
//
//            //initiate the data sharing
//            WCSession.default.sendMessage(message, replyHandler:
//                {(result) -> Void in
//
//                    if result["workoutData"] != nil
//                    {
//                        let loadedData = result["workoutData"]
//
//                        NSKeyedUnarchiver.setClass(InfoClass.self, forClassName: "InfoObject")
//
//                        let loadedWorkout = NSKeyedUnarchiver.unarchiveObject(with: loadedData as! Data) as? InfoClass
//
//                        workoutInfo = loadedWorkout!
//
//                        if(workoutInfo.waterCount != nil)
//                        {
//                            wCount = workoutInfo.waterCount!
//                        }
//
//                    }
//
//            }, errorHandler: {(error) -> Void in print(error)})
//
//        }
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
