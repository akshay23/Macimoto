//
//  Animoto.swift
//  Macimoto
//
//  Created by Akshay Bharath on 12/7/15.
//  Copyright © 2015 Akshay Bharath. All rights reserved.
//

import Foundation
import Alamofire

struct Animoto {
  enum Router: URLRequestConvertible {
    static let baseURLString = "https://app-service.animoto.com"
    static let clientID = "iphone"
    static let clientSecret = "iphone2secret"
    //static let redirectURI = "http://www.animoto.com/"
    //static let authorizationURL = NSURL(string: Router.baseURLString + "/oauth/authorize/?client_id=" + Router.clientID + "&redirect_uri=" + Router.redirectURI + "&response_type=code")!
    
    case Authenticate
    
    static func requestAccessTokenURLStringAndParms() -> (URLString: String, Params: [String: AnyObject]) {
      let params = ["grant_type": "client_credentials"]
      let pathString = "/oauth/access_token"
      let urlString = Animoto.Router.baseURLString + pathString
      return (urlString, params)
    }
    
    var URLRequest: NSMutableURLRequest {
      let (path, parameters): (String, [String: AnyObject]) = {
        switch self {
        case .Authenticate:
          let pathString = "/oauth/access_token"
          return (pathString, [:])
        }
      }()
      
      let BaseURL = NSURL(string: Router.baseURLString)
      let URLRequest = NSURLRequest(URL: BaseURL!.URLByAppendingPathComponent(path))
      let encoding = Alamofire.ParameterEncoding.URL
      return encoding.encode(URLRequest, parameters: parameters).0
    }
  }
}