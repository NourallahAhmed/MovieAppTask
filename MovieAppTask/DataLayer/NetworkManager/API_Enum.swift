//
//  API_Enum.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 25/07/2024.
//

import Foundation
import Moya

enum MovieAPIs{
    case movieList(page: Int)
    case movieDetails(id: String)
}

class test {
    
}
extension  MovieAPIs : Moya.TargetType{
    var baseURL: URL {
        
        return URL(string:
                    appConstants.baseURL.rawValue)!
     
        
    }
    
    var path: String {
        switch self{
        case .movieList:
            return appConstants.movieListEndPoint.rawValue
        case .movieDetails(let id ):
            return appConstants.movieDetailsEndPoint.rawValue + id
        }
    }
    
    var method: Moya.Method {
        switch self{
            default:
            return .get
        }
    }
    var task: Moya.Task {
          switch self {
              
          case .movieList(let page):
              var params: [String: Any] = [:]
              params["api_key"] = appConstants.apiKey.rawValue
              params["page"] = "\(page)"
              return .requestParameters(parameters: params, encoding: URLEncoding.default)
          case .movieDetails(_):

              var params: [String: Any] = [:]
              params["api_key"] = appConstants.apiKey.rawValue
              return .requestParameters(parameters: params, encoding: URLEncoding.default)
          }
    }
    
    var headers: [String : String]? {
        var header :[String:String] = [:]
        switch self {
        default:

            header["accept"] = "application/json"
        }
        return header
    }
    

}
