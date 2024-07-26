//
//  CustomAlerts.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//


import Foundation
import SwiftMessages


class Alert{
    static var disconnectedConfig = SwiftMessages.Config()
    static var connectedConfig = SwiftMessages.Config()
    static var successConfig = SwiftMessages.Config()
    static var warningConfig = SwiftMessages.Config()
    static var successView = MessageView()
    static var warningView = MessageView()
    static var disconnectedView = MessageView()
    static var connectedView = MessageView()
    
    static var retryImplemenation : (() -> ()) = { }
    static var retryNoNetworkAlert : (() -> ()) = { }
    
    
    @MainActor static func initiateSwiftMessagesViews() {
        Alert.setupDisconnectedView()
        Alert.setupConnectedView()
        Alert.setupWarningView()
    }
    
  
    @objc func onTapSetting(){
        DispatchQueue.main.async {
            
                NSLog("setting")
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }
    }


    @MainActor static func setupSuccessView(){
        successView = MessageView.viewFromNib(layout: .messageView)
        successView.configureTheme(.success, iconStyle: .subtle)
        successView.backgroundView.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.7098039216, blue: 0, alpha: 1)
        
        
        successView.configureDropShadow()
        successView.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        (successView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        successView.button?.isHidden = true

        successConfig = SwiftMessages.defaultConfig
        successConfig.duration = .automatic
        successConfig.ignoreDuplicates = true
        successConfig.presentationContext = .window(windowLevel: .normal)
        successView.button?.addTarget(self, action: #selector(hideErrorAlert), for: .touchUpInside)
    }
    
    @MainActor static func setupWarningView() {
        warningView = MessageView.viewFromNib(layout: .messageView)
        warningView.configureTheme(.warning, iconStyle: .subtle)

        // Add a drop shadow.
        warningView.configureDropShadow()
        warningView.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        (warningView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        warningView.button?.isHidden = true
        warningView.titleLabel?.textColor = .black
        warningView.bodyLabel?.textColor = .black
        warningConfig = SwiftMessages.defaultConfig
        warningConfig.duration = .automatic
        warningConfig.ignoreDuplicates = true
        warningConfig.presentationContext = .window(windowLevel: .normal)
        successView.button?.addTarget(self, action: #selector(hideErrorAlert), for: .touchUpInside)
    }
    

    @MainActor static func setupDisconnectedView() {
 
        disconnectedView = MessageView.viewFromNib(layout: .statusLine)
        disconnectedView.configureTheme(.error)
        disconnectedConfig = SwiftMessages.defaultConfig
        disconnectedConfig.duration = .forever
        disconnectedConfig.ignoreDuplicates = true
        disconnectedConfig.interactiveHide = false
    }

    static func showDisconnectedMessage() {
        DispatchQueue.main.async {
            disconnectedView.configureContent(body: "NoInternet")
            SwiftMessages.show(config: disconnectedConfig, view: disconnectedView)
        }
    }
    static func hideDisconnectedMessage() {
        DispatchQueue.main.async {
            SwiftMessages.hide()
        }
    }
    @MainActor static func setupConnectedView() {
        connectedView = MessageView.viewFromNib(layout: .statusLine)
        connectedView.configureTheme(.success)
        connectedConfig = SwiftMessages.defaultConfig
        connectedConfig.duration = .seconds(seconds: 20)
        connectedConfig.ignoreDuplicates = true
    }
    static func showConnectedMessage() {
        DispatchQueue.main.async {
            connectedView.configureContent(body: "NetworkConnected")
            SwiftMessages.show(config: connectedConfig, view: connectedView)
        }
    }
    static func hideConnectedMessage() {
        DispatchQueue.main.async {
            SwiftMessages.hide()
        }
    }
    
    
    @objc static func retryActionAlert() {
        DispatchQueue.main.async {
            SwiftMessages.hide()
            Alert.retryImplemenation()
        }
    }
  
    
    @objc static func hideErrorAlert() {
        DispatchQueue.main.async {
            SwiftMessages.hide()
        }
    }
 
}

