//
//  BaseViewController.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
import UIKit
class BaseViewController : UIViewController  , NetworkReachabilityDelegate{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkConnectivity.shared.delegate = self

    }
    
    func networkStatusDidChange(isConnected: Bool) {
        if isConnected {
            Alert.hideDisconnectedMessage()
        }else{
            Alert.showDisconnectedMessage()
        }
    }
}
