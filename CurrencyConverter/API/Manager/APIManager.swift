//
//  APIManager.swift
//  CurrencyConverter
//
//  Created by Vijith T.V on 31/03/19.
//  Copyright © 2019 Vijith T.V. All rights reserved.
//

import Foundation

typealias successBlock = ((_ JSON: Any) -> ())
typealias failureBlock = ((_ error: String) -> ())

class APIManager {
    
    /// Get All Currencies
    ///
    /// - Parameters:
    ///   - success: Success block
    ///   - failure: Failure Block
    
    static func getCurrencies(success: @escaping successBlock,
                              failure: @escaping failureBlock) {
        
        let urlComp = NSURLComponents(string: Routes.currencies)!
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if response?.getStatusCode() == 200 {
                
                let json = self.parseJSON(data: data, error: error, response: response)
                success(json)
            } else {
                failure(error?.localizedDescription ?? "")
            }
            
        })
        task.resume()
    }
    
    /// Currencey Conversion URL Request
    ///
    /// - Parameters:
    ///   - params: Parameters, currency symbol, name, amount
    ///   - success: Success callback method
    ///   - failure: Failure callback method
    
    static func conversion(params: [String: String],
                           onSuccess success: @escaping successBlock,
                           onFailure failure: @escaping failureBlock) {
        
        let urlComp = NSURLComponents(string: Routes.baseUrl)!
        
        var items = [URLQueryItem]()
        
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if response?.getStatusCode() == 200 {
                
                let json = self.parseJSON(data: data, error: error, response: response)
                success(json)
            } else {
                failure(error?.localizedDescription ?? "")
            }
            
        })
        task.resume()
    }
    
    /// Parse JSON
    ///
    /// - Parameters:
    ///   - data: Data
    ///   - error: Error
    ///   - response: URLResponse
    /// - Returns: Any Value
    
    private static func parseJSON(data: Data?,
                                  error: Error?,
                                  response: URLResponse?) -> Any {
        
        guard let dataResponse = data,
            error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return (Any).self }
        do{
            //here dataResponse received from a network request
            let jsonResponse = try JSONSerialization.jsonObject(with:
                dataResponse, options: [])
            
            return jsonResponse
            
        } catch let parsingError {
            print("Error", parsingError)
        }
        return "No Response" as Any
    }
    
}
