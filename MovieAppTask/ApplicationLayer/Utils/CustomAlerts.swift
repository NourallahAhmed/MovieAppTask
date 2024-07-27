//
//  CustomAlerts.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//


import Foundation
import SwiftMessages


class Alert{
    private var disconnectedConfig = SwiftMessages.Config()
    private var disconnectedView = MessageView()
    
    private var connectedConfig = SwiftMessages.Config()
    private var connectedView = MessageView()
    
    private var config = SwiftMessages.Config()
    private var errorView = MessageView()
    
    private var retryNoNetworkAlert : (() -> ()) = { }
    
    
    private static var instance = Alert()
    
    public  static var shared : Alert {
        return instance
    }
    
    @MainActor  func initiateSwiftMessagesViews() {
        setupDisconnectedView()
        setupConnectedView()
        setupErrorView()
    }
    
    
    @MainActor  func setupErrorView() {
        errorView = MessageView.viewFromNib(layout: .messageView)
        errorView.configureTheme(.error , iconStyle: .subtle)
        
        // Add a drop shadow.
        errorView.configureDropShadow()
        errorView.button?.isHidden = true
        
        errorView.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        (errorView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        config = SwiftMessages.defaultConfig
        config.duration = .automatic
        
        config.ignoreDuplicates = true
        config.presentationContext = .window(windowLevel: .normal)
        errorView.button?.addTarget(self, action: #selector(hideErrorAlert), for: .touchUpInside)
    }
    
    @MainActor  func setupDisconnectedView() {
        
        disconnectedView = MessageView.viewFromNib(layout: .statusLine)
        disconnectedView.configureTheme(.error)
        disconnectedConfig = SwiftMessages.defaultConfig
        disconnectedConfig.duration = .forever
        disconnectedConfig.ignoreDuplicates = true
        disconnectedConfig.interactiveHide = false
    }
    
    @MainActor  func setupConnectedView() {
        connectedView = MessageView.viewFromNib(layout: .statusLine)
        connectedView.configureTheme(.success)
        connectedConfig = SwiftMessages.defaultConfig
        connectedConfig.duration = .seconds(seconds: 1)
        connectedConfig.ignoreDuplicates = true
    }
    
    func showDisconnectedMessage() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return }
            self.disconnectedView.configureContent(body: "No Internet")
            SwiftMessages.show(config: self.disconnectedConfig, view: self.disconnectedView)
        }
    }
    
    func showConnectedMessage() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return }
            self.connectedView.configureContent(body: "Network Connected")
            SwiftMessages.show(config: self.connectedConfig, view: self.connectedView)
        }
    }
    
    
    
    func showErrorMessage(title: String = "Error", body: String){
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.errorView.configureContent(title: title, body: body,iconImage:
                                                UIImage(systemName: "exclamationmark.triangle.fill")!)
            SwiftMessages.show(config: self.config, view: self.errorView)
        }
    }
    
    @objc  func retryActionAlert() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return }
            SwiftMessages.hide()
            self.retryActionAlert()
        }
    }
    
    
    @objc  func hideErrorAlert() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return }
            SwiftMessages.hide()
        }
    }
    
}

