//
//  Workout.swift
//  LewisKendrick_KeenFit_Watch
//
//  Created by kendrick lewis on 3/13/18.
//  Copyright © 2018 kendrick lewis. All rights reserved.
//

import UIKit

class Workout: NSObject, NSCoding
{
    var workout: String?
    var isDone: Bool?
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.workout, forKey: "workoutString")
        aCoder.encode(self.isDone, forKey: "isDoneBool")
    }
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let workoutString = aDecoder.decodeObject(forKey: "workoutString") as? String,
            let isDoneBool = aDecoder.decodeObject(forKey: "isDoneBool") as? Bool
        
         else {return nil}
        
        self.init()
        self.initWithData(mWorkout: workoutString, mIsDone: isDoneBool)
    }
    
    func initWithData(mWorkout: String, mIsDone: Bool)
    {
        workout = mWorkout
        isDone = mIsDone
    }
}
