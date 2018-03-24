//
//  WorkoutInterfaceController.swift
//  LewisKendrick_KeenFit_Watch WatchKit Extension
//
//  Created by kendrick lewis on 3/13/18.
//  Copyright © 2018 kendrick lewis. All rights reserved.
//

import UIKit
import WatchKit
import Foundation
import WatchConnectivity

var workoutInfo = InfoClass()
var wCount = 0

class WorkoutInterfaceController: WKInterfaceController, WCSessionDelegate
{
    
    @IBOutlet var workoutTable: WKInterfaceTable!
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int)
    {
        if let selectedRow = workoutTable.rowController(at: rowIndex) as? WorkoutRowController
        {
            if(workoutInfo.workoutBoolArray[rowIndex] != true)
            {
                selectedRow.rowGroup.setBackgroundColor(UIColor.gray)
                selectedRow.rowDetail.setText("Done")
                workoutInfo.finshedWorkout(didFinish: true, atIndex: rowIndex)
            }
            else
            {
                selectedRow.rowGroup.setBackgroundColor(UIColor.purple)
                selectedRow.rowDetail.setText("Todo")
                workoutInfo.finshedWorkout(didFinish: false, atIndex: rowIndex)
            }
            
        }
    }
    
    //trafering infomation from iphone to iwatch
    //---------------------------------------------------------------------------------
    //---------------------------------------------------------------------------------
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
    {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any] )
    {
        //unserilaze and decode any data we have
       // var replyValues = Dictionary<String, AnyObject>()
        
        let loadedData = message["workoutData"]
        
        let loadedWorkout = NSKeyedUnarchiver.unarchiveObject(with: loadedData as! Data) as? InfoClass
        
        workoutInfo = loadedWorkout!
        //letting the iphone know we got the data so it wont send again
       // replyValues["status"] = "Program Recieved" as AnyObject?
       // replyHandler(replyValues)
        
        start()
    }
    
    func start()
    {
        wCount = workoutInfo.waterCount!
        
        self.workoutTable .setNumberOfRows(workoutInfo.workoutStringArray.count, withRowType: "workoutRow")
        for (index, workout) in workoutInfo.workoutStringArray.enumerated()
        {
            let row = self.workoutTable.rowController(at: index) as! WorkoutRowController
            
            row.rowTitle.setText(workout)
            
            if(workoutInfo.workoutBoolArray[index] == true)
            {
                row.rowGroup.setBackgroundColor(UIColor.gray)
                row.rowDetail.setText("Done")
            }
            else
            {
                row.rowGroup.setBackgroundColor(UIColor.purple)
                row.rowDetail.setText("Todo")
            }
            
        }
    }
    
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
        // Configure interface objects herevar
        
        // checking the session
        if(WCSession.isSupported())
        {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
        // loadTableData()
        
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
        
        if(WCSession.default.isReachable)
        {
            //this is calling to the phone asking for data
            let message = ["getWorkoutData" : [:]]
            
            //initiate the data sharing
            WCSession.default.sendMessage(message, replyHandler:
                {(result) -> Void in
                
                if result["workoutData"] != nil
                {
                   let loadedData = result["workoutData"]
                            
                   NSKeyedUnarchiver.setClass(InfoClass.self, forClassName: "InfoObject")
                    
                   let loadedWorkout = NSKeyedUnarchiver.unarchiveObject(with: loadedData as! Data) as? InfoClass
                            
                   workoutInfo = loadedWorkout!
            
            
                   self.workoutTable.setNumberOfRows(workoutInfo.workoutStringArray.count, withRowType: "workoutRow")
                    
                    if(workoutInfo.waterCount != nil)
                    {
                    wCount = workoutInfo.waterCount!
                    }
                    
                            for (index, workout) in workoutInfo.workoutStringArray.enumerated()
                            {
                                let row = self.workoutTable.rowController(at: index) as! WorkoutRowController
                                
                                row.rowTitle.setText(workout)
                                
                                if(workoutInfo.workoutBoolArray[index] == true)
                                {
                                    row.rowGroup.setBackgroundColor(UIColor.gray)
                                    row.rowDetail.setText("Done")
                                }
                                else
                                {
                                    row.rowGroup.setBackgroundColor(UIColor.purple)
                                    row.rowDetail.setText("Todo")
                                }
                                
                            }
                 }
                    
               }, errorHandler: {(error) -> Void in print(error)})
       }
}
    
    
}
