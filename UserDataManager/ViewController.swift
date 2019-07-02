//
//  ViewController.swift
//  UserDataManager
//
//  Created by kumar reddy on 02/07/19.
//  Copyright © 2019 kumar reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dataManager = DataManager(datasource: UserDefaults.standard)
        
        // use canShowInFreshAppLaunch, if you want to show a particular on-boarding or tooltips only when a user launch the application (cold start) for n number of times
        if dataManager.canShowInFreshAppLaunch(for: "showOnboarding", maxCount: 3) {
            print("show onboarding")
        } else {
            print("already shown onboarding in the current launch")
        }
    
        // use canShowInSession if you want to show a particular on-boarding or tooltips in a particular session for n number of times
        if dataManager.canShowInSession(for: "showOnboarding", maxCount: 3) {
            print("show onboarding")
        } else {
            print("already shown onboarding in the current session for max number of times")
        }
        
        // use canShow if you want to show a particular on-boarding or tooltips for n number of times without having any relation with launch or session
        if dataManager.canShow(for: "showOnboarding", maxCount: 3) {
            print("show onboarding")
        } else {
            print("already completed the max number of times")
        }
    }
}

