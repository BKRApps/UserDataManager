//
//  DataManager.swift
//  UserDataManager
//
//  Created by kumar reddy on 02/07/19.
//  Copyright © 2019 kumar reddy. All rights reserved.
//

import Foundation

public final class DataManager {
    private let datasource: UserDefaults
    
    public init(datasource: UserDefaults = UserDefaults.standard) {
        self.datasource = datasource
    }
    
    /**
     used to check to show specific features or onboarding for app launches
     - parameter type: name of the experiment
     - parameter maxCount : max number of items this should be shown in app fresh launch
     - parameter incrementIfRequired: it will not increment the counter if it is false.
     - returns: true if is needs to show for this app launch.
     */
    public func canShowInFreshAppLaunch(for type: String,
                                        maxCount: Int,
                                        incrementIfRequired: Bool = true) -> Bool {
        let newType = type+"_app_launch"
        let boolLaunchType = newType+"_flag"
        let countLaunchType = newType+"_count"
        let isAlreadyProcessed = datasource.bool(forKey: boolLaunchType)
        let existingCount = datasource.integer(forKey: countLaunchType)
        if existingCount < maxCount && isAlreadyProcessed == false {
            if incrementIfRequired {
                datasource.set(true, forKey: boolLaunchType)
                datasource.set(existingCount+1, forKey: countLaunchType)
            }
            return true
        }
        return false
    }
    
    /**
     used to check to show specific features or onboarding in the session
     - parameter type: name of the experiment
     - parameter maxCount : max number of items this should be shown in the session
     - parameter incrementIfRequired: it will not increment the counter if it is false.
     - returns: true if is needs to show for this app launch.
     */
    public func canShowInSession(for type: String,
                                 maxCount: Int,
                                 incrementIfRequired: Bool = true) -> Bool {
        let sessionCount = type+"_session_count"
        let existingCount = datasource.integer(forKey: sessionCount)
        if existingCount < maxCount {
            if incrementIfRequired {
                datasource.set(existingCount+1, forKey: sessionCount)
            }
            return true
        }
        return false
    }
    
    /**
     used to check to show specific features or onboarding regardless of app launch or session
     - parameter type: name of the experiment
     - parameter maxCount: max number of items this should be shown
     - parameter incrementIfRequired: it will not increment the counter if it is false.
     - returns: true if is needs to show for this app launch.
     */
    public func canShow(for type: String,
                        maxCount: Int,
                        incrementIfRequired: Bool = true) -> Bool {
        let existingCount = datasource.integer(forKey: type)
        if existingCount < maxCount {
            if incrementIfRequired {
                datasource.set(existingCount+1, forKey: type)
            }
            return true
        }
        return false
    }
    
    /**
     Call this method from didFinishLaunchingWithOptions of AppDelegate
     */
    public func resetAllSessionAndAppLaunchFlags() {
        DispatchQueue.init(label: "resetUserDefaults").async {
            for key in self.datasource.dictionaryRepresentation().keys {
                if key.contains("_session_count") {
                    self.datasource.set(0, forKey: key)
                } else if key.contains("_app_launch_flag") {
                    self.datasource.set(false, forKey: key)
                }
            }
        }
    }
}

