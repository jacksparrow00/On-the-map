//
//  ParseAPIClient.swift
//  On the map
//
//  Created by Nitish on 26/12/16.
//  Copyright © 2016 Nitish. All rights reserved.
//

import Foundation
class ParseAPIClient: NSObject{
    let session = URLSession.shared
    
    func taskForGetStudentLocation(completionForGetStudentLocation: @escaping(_ result: AnyObject?,_ error: String?) -> Void) {
        let parameter:[String:Any] = [ParseAPIClient.ParseAPIParameterKeys.limit : 100,
                                      ParseAPIClient.ParseAPIParameterKeys.skip : 0,
                                      ParseAPIClient.ParseAPIParameterKeys.order : "-updatedAt"]
        let request = NSMutableURLRequest(url: urlGenerator(parameter: parameter))
        request.addValue(ParseAPIClient.ParseAPIKeyConstants.ApplicationKey, forHTTPHeaderField: "X-ParseApplication-Id")
        request.addValue(ParseAPIClient.ParseAPIKeyConstants.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            func sendError(errorString: String){
                print(errorString)
                completionForGetStudentLocation(nil,errorString)
                
            }
            
            guard error == nil else{
                sendError(errorString: "Your request returned an error \(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode > 200 && statusCode < 300 else{
                sendError(errorString: "Your request returned status code other than 2xx")
                return
            }
            
            guard let data = data else{
                sendError(errorString: "Your request did not return any data")
                return
            }
            
            self.convertDataWithCompletionHandler(data: data, completionHandlerForConvertData: completionForGetStudentLocation)
        }
        task.resume()
        
    }
    
    func taskForGetLocation(uniqueKey: String,completionForGetLocation: @escaping(_ result: AnyObject?, _ error: String?) -> Void) {
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation?where=%7B%22uniqueKey%22%3A%22\(uniqueKey)%22%7D"
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.addValue(ParseAPIClient.ParseAPIKeyConstants.ApplicationKey, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseAPIClient.ParseAPIKeyConstants.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            func sendError(errorString: String){
                print(errorString)
                completionForGetLocation(nil,errorString)
            }
            
            guard error == nil else{
                sendError(errorString: "Your request returned an error \(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode > 200 && statusCode < 300 else{
                sendError(errorString: "Your request returned status code other than 2xx")
                return
            }
            
            guard let data = data else{
                sendError(errorString: "Your request did not return any data")
                return
            }
            
            self.convertDataWithCompletionHandler(data: data, completionHandlerForConvertData: completionForGetLocation)
        }
        task.resume()
    }
    
    func taskForPostLocation(uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double, completionHandlerForPost: @escaping(_ result: AnyObject?, _ error: String?) -> Void) {
        let request = NSMutableURLRequest(url: urlGenerator(parameter: nil))
        request.httpMethod = "POST"
        request.addValue(ParseAPIClient.ParseAPIKeyConstants.ApplicationKey, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseAPIClient.ParseAPIKeyConstants.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue(ParseAPIClient.ParseAPIKeyConstants.ApplicationJson, forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"\(ParseAPIClient.ParseAPIConstants.uniqueKey)\": \"\(uniqueKey)\" , \"\(ParseAPIClient.ParseAPIConstants.firstName)\" : \"\(firstName)\" , \"\(ParseAPIClient.ParseAPIConstants.lastName)\" : \"\(lastName)\" , \"\(ParseAPIClient.ParseAPIConstants.mapString)\" : \"\(mapString)\" , \"\(ParseAPIClient.ParseAPIConstants.mediaURL)\" : \"\(mediaURL)\" , \"\(ParseAPIClient.ParseAPIConstants.latitude)\" :  \(latitude), \"\(ParseAPIClient.ParseAPIConstants.longitude)\" : \(longitude)}".data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            func sendError(errorString: String){
                print(errorString)
                completionHandlerForPost(nil,errorString)
            }
            
            guard error == nil else{
                sendError(errorString: "Your request returned an error \(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode > 200 && statusCode < 300 else{
                sendError(errorString: "Your request returned status code other than 2xx")
                return
            }
            
            guard let data = data else{
                sendError(errorString: "Your request did not return any data")
                return
            }
            self.convertDataWithCompletionHandler(data: data, completionHandlerForConvertData: completionHandlerForPost)
        }
        task.resume()
    }
    
    func taskForPutMethod(objectID: String,uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double, completionHandlerForPost: @escaping (_ result: Bool?, _ error: String?) -> Void) {
        var urlString = String(describing: urlGenerator(parameter: nil))
        urlString = urlString + "/\(objectID)"
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue(ParseAPIClient.ParseAPIKeyConstants.ApplicationKey, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseAPIClient.ParseAPIKeyConstants.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue(ParseAPIClient.ParseAPIKeyConstants.ApplicationJson, forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"\(ParseAPIClient.ParseAPIConstants.uniqueKey)\": \"\(uniqueKey)\" , \"\(ParseAPIClient.ParseAPIConstants.firstName)\" : \"\(firstName)\" , \"\(ParseAPIClient.ParseAPIConstants.lastName)\" : \"\(lastName)\" , \"\(ParseAPIClient.ParseAPIConstants.mapString)\" : \"\(mapString)\" , \"\(ParseAPIClient.ParseAPIConstants.mediaURL)\" : \"\(mediaURL)\" , \"\(ParseAPIClient.ParseAPIConstants.latitude)\" :  \(latitude), \"\(ParseAPIClient.ParseAPIConstants.longitude)\" : \(longitude)}".data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            func sendError(errorString: String){
                print(errorString)
                completionHandlerForPost(false,errorString)
            }
            
            guard error == nil else{
                sendError(errorString: "Your request returned an error \(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode > 200 && statusCode < 300 else{
                sendError(errorString: "Your request returned status code other than 2xx")
                return
            }
            
            guard let data = data else{
                sendError(errorString: "Your request did not return any data")
                return
            }
            completionHandlerForPost(true, nil)
        }
        task.resume()
    }
    
    private func urlGenerator(parameter:[String:Any]?) -> URL{
        var components = URLComponents()
        components.scheme = ParseAPIClient.ParseAPIKeyConstants.ApiScheme
        components.host = ParseAPIClient.ParseAPIKeyConstants.ApiHost
        components.path = ParseAPIClient.ParseAPIKeyConstants.ApiPath
        components.queryItems = [URLQueryItem]()
        
        if let parameter = parameter{
            for (key,value) in parameter{
                let queryitem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems?.append(queryitem)
            }
        }
        return components.url!
    }
    
    /*private func escapingParameters(parameters:[String:AnyObject]) -> String{
        if parameters.isEmpty {
            return ""
        }else{
            var keyValuePair = [String]()
            
            for (key,value) in parameters{
                let stringValue = "\(value)"
                
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                keyValuePair.append(key + "=" + "\(escapedValue)")
            }
            return "?\(keyValuePair.joined(separator: "&"))"
        }
    }*/
    
    private func convertDataWithCompletionHandler(data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: String?) -> Void){
        var parsedResult:AnyObject!
        do{
            parsedResult = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject!
        }catch{
            print(error)
            completionHandlerForConvertData(nil, error.localizedDescription)
        }
        completionHandlerForConvertData(parsedResult,nil)
    }
    
    class func sharedInstance() -> ParseAPIClient{
        struct Singleton{
            static var sharedInstance = ParseAPIClient()
        }
        return Singleton.sharedInstance
    }
}
