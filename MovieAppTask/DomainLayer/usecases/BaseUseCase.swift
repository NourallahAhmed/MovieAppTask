//
//  BaseUseCase.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
protocol BaseUseCase {
    associatedtype ResponseType
    associatedtype InputType
    associatedtype NetworkManager
    
    // Define a method that takes input and returns a response
    func execute(input: InputType , networkManager: NetworkManager) -> ResponseType
}
