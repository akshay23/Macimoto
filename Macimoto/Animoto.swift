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
    static let baseURLString = "https://app-service-qa.animoto.com"
    static let clientID = "iphone"
    static let clientSecret = "iphone2secret"
    
    case Authenticate
    
    static func requestAccessTokenURLStringAndParms() -> (URLString: String, Params: [String: AnyObject]) {
      let params = ["grant_type": "client_credentials"]
      let pathString = "/oauth/access_token"
      let urlString = Animoto.Router.baseURLString + pathString
      return (urlString, params)
    }
    
    static func requestLoginStringAndParms(username: String, password: String) -> (URLString: String, Params: [String: AnyObject]) {
      let params = ["grant_type": "password", "username": username, "password": password]
      let pathString = "/oauth/access_token"
      let urlString = Animoto.Router.baseURLString + pathString
      return (urlString, params)
    }
    
    static func requestProjectsWithPageNumber(userID: Int, page: Int) -> (URLString: String, Params: [String: AnyObject]) {
      let params = ["page_size": 10, "page_number": 1]
      let pathString = "/projects?page_size=10&page_number=1"
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