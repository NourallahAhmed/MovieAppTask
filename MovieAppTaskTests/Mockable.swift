//
//  Mocable.swift
//  MovieAppTaskTests
//
//  Created by NourAllah Ahmed on 28/07/2024.
//

import Foundation
protocol Mockable :AnyObject {
    var bundle: Bundle {get}
    func loadJson <T: Decodable>(fileName: String , type: T.Type) -> T
}
extension Mockable {
    var bundle : Bundle {
        return Bundle(for: type(of:self))
    }
    
    
    func loadJson <T: Decodable>(fileName: String , type: T.Type) -> T {
        guard let path = bundle.url(forResource: fileName, withExtension: "json")
        else{
            fatalError("Falid to load the Json file")
        }
        
        do{
            let data = try Data(contentsOf: path)
            
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            
            return decodedObject
        }catch{
            fatalError("Falid to decode the object")
        }
    }
}
