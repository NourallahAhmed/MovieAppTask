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
        view.backgroundColor = .black
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
