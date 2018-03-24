//
//  SecondViewController.swift
//  LewisKendrick_KeenFit_Watch
//
//  Created by kendrick lewis on 3/12/18.
//  Copyright © 2018 kendrick lewis. All rights reserved.
//

import UIKit
import WatchConnectivity

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WCSessionDelegate
{
    //outlet for my water counter
    @IBOutlet weak var waterCount_lbl: UILabel!
    //used to capture info in the add workout
    @IBOutlet weak var workoutInput_txt: UITextField!
    
    //creating a string array to hold my workouts
    var workoutArray = [(String, Bool)]()
    var workoutInfo: InfoClass = InfoClass()
    var lastMessageTime: CFAbsoluteTime = 0 //this will see when an item is sent
    
    //creating tableview so i can call to it
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //scheduledTimerWithTimeInterval()
        
        if(WCSession.isSupported())
        {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else
        {
            print("WatchCnnectivity is not supported right now")
        }
        
        
        workoutInfo.initWithData(wCount: 0, wStringArray: [], wBoolArray: [])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //setting up Methods for WCSESSION
    //-----------------------------------------------
    //-----------------------------------------------
    //-----------------------------------------------
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //nothing
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //nothing
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //nothing
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        var replyValues = Dictionary<String, AnyObject>()
        
        if(message["getWorkoutData"] != nil)
        {
            //this is where i am going to send the data
            NSKeyedArchiver.setClassName("InfoObject", for: InfoClass.self)
            
            let workoutData = NSKeyedArchiver.archivedData(withRootObject: workoutInfo)
            
            replyValues["workoutData"] = workoutData as AnyObject?
            replyHandler(replyValues)
        }
    }
    
    //setting up my buttons and actions
    //-----------------------------------------------
    //-----------------------------------------------
    //-----------------------------------------------
    
    //this will make my counter change
    @IBAction func countChanged(_ sender: UIStepper)
    {
        let waterInt = Int(sender.value)
       // waterCount_lbl.text = String(waterInt)
        workoutInfo.setCount(newCount: waterInt)
        waterCount_lbl.text = String(workoutInfo.waterCount!)
        sendWatchMessage()
    }
    
    @IBAction func addWorkout(_ sender: UIButton)
    {
        if (workoutInput_txt.text != "")
        {
            let inputText = workoutInput_txt.text
            
            workoutInfo.addToArray(items: (inputText!, false))
            sendWatchMessage()
            workoutInput_txt.text = ""
            tableView.reloadData()
        }
        
    }
    
    
    //starting my table view set up
    //-----------------------------------------------
    //-----------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return workoutInfo.workoutStringArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_01", for: indexPath)
        
        let currentWorkout = workoutInfo.workoutStringArray[indexPath.row]
        let currentWorkoutBool = workoutInfo.workoutBoolArray[indexPath.row]
        
        cell.textLabel?.text = currentWorkout
        
        if(currentWorkoutBool == true)
        {
            cell.backgroundColor = UIColor.gray
            cell.detailTextLabel?.text = "Finished"
        }
        else
        {
            cell.backgroundColor = UIColor.purple
            cell.detailTextLabel?.text = "TODO"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let currentWorkout = workoutInfo.workoutBoolArray[indexPath.row]
        
        if(currentWorkout == true)
        {
            workoutInfo.finshedWorkout(didFinish: false, atIndex: indexPath.row)
        }
        else
        {
            workoutInfo.finshedWorkout(didFinish: true, atIndex: indexPath.row)
        }
        
        tableView.reloadData()
        sendWatchMessage()
        
    }
    
    //setting up my the info to send to my watch
    //-----------------------------------------------
    //-----------------------------------------------
    //-----------------------------------------------
    
//    var timer = Timer()
//    func scheduledTimerWithTimeInterval(){
//        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
//        timer = Timer.init(timeInterval: 1.0, target: self, selector: Selector(("sendDataToWatch")), userInfo: nil, repeats: true)
//    }
    
    
    func sendWatchMessage()
    {
        NSKeyedArchiver.setClassName("InfoObject", for: InfoClass.self)
        let messageData = NSKeyedArchiver.archivedData(withRootObject: workoutInfo)
        
        let currentTime = CFAbsoluteTimeGetCurrent()
        
        if lastMessageTime + 0.5 > currentTime
        {
            //this will make sure i dont send to early
        }
        
        if(WCSession.default.isReachable)
        {
            //this will make sure im connected before i send
            let message = ["workoutData" : messageData]
            
            WCSession.default.sendMessage(message, replyHandler: nil)
        }
        
        lastMessageTime = CFAbsoluteTimeGetCurrent()
    }
    
    
    
    @IBAction func saveIntake(_ sender: UIButton)
    {
        sendWatchMessage()
    }
    

}
