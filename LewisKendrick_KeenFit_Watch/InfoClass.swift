//
//  InfoClass.swift
//  LewisKendrick_KeenFit_Watch
//
//  Created by kendrick lewis on 3/13/18.
//  Copyright © 2018 kendrick lewis. All rights reserved.
//

import UIKit

class InfoClass: NSObject, NSCoding
{
    var waterCount: Int?
    var workoutStringArray: [String] = []
    var workoutBoolArray: [Bool] = []
    
 
    func initWithData(wCount: Int, wStringArray: [String], wBoolArray: [Bool] )
    {
        waterCount = wCount
        workoutStringArray = wStringArray
        workoutBoolArray = wBoolArray
    }
    
    func setCount(newCount: Int)
    {
        waterCount = newCount
    }
    
    func addToArray(items: (String, Bool))
    {
        let workout: Workout = Workout()
        workout.initWithData(mWorkout: items.0, mIsDone: items.1)
        workoutStringArray.append(items.0)
        workoutBoolArray.append(items.1)
    }
    
    func finshedWorkout(didFinish: Bool, atIndex: Int)
    {
        workoutBoolArray[atIndex] = didFinish
    }
    
    func encode(with aCoder: NSCoder)
    {
        //this takes the object and encodes it for sending to the watch
        aCoder.encode(self.waterCount, forKey: "waterCount")
        aCoder.encode(self.workoutStringArray, forKey: "workoutStringArray")
        aCoder.encode(self.workoutBoolArray, forKey: "workoutBoolArray")
    }
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let water = aDecoder.decodeObject(forKey: "waterCount") as? Int,
        let wStringArray = aDecoder.decodeObject(forKey: "workoutStringArray") as? [String],
        let wBoolArray = aDecoder.decodeObject(forKey: "workoutBoolArray") as? [Bool]
        else
        {
            return nil
        }
        
        self.init()
        self.initWithData(wCount: water, wStringArray: wStringArray, wBoolArray: wBoolArray)
    }
    
}
