//
//  API_Enum.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 25/07/2024.
//

import Foundation
import Moya

enum MovieAPIs{
    case movieList
    case movieDetails(id: String)
}


extension  MovieAPIs : Moya.TargetType{
    var baseURL: URL {
        
        return URL(string:
                    appConstants.baseURL.rawValue)!
            //https://api.themoviedb.org/3/movie/1022789?api_key=7d90f9a3023dd78ccdf548ec38d982b8
        
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
            default:

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
