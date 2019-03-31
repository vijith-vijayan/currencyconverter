//
//  APIHandler.swift
//  CurrencyConverter
//
//  Created by Vijith T.V on 31/03/19.
//  Copyright © 2019 Vijith T.V. All rights reserved.
//

import Foundation

class APIHandler {
    
    init() { }
    
    
    /// All currencies
    ///
    /// - Returns: Array of currencies
    
    static func currencyValues(completion: @escaping ([Currencies]) -> ()) {
        
        var currencies = [Currencies]()
        
        APIManager.getCurrencies(success: { (response) in
        
            guard let jsonArray = response as? [String: Any] else {
                return
            }
        
            for json in jsonArray {
                let currency = Currencies(
                    symbol: json.key ,
                    fullName: json.value as? String ?? ""
                )
                currencies.append(currency)
            }
            completion(currencies)
            
        }) { (error) in
            
            print(error)
        }
    }
    
    /// Conversion
    ///
    /// - Parameter params: Parameters
    /// - Parameter params: Conversion values
    /// - Returns: Dictionary of string
    static func conversion(params: [String: String],
                           conversionBlock: @escaping (Values) -> ()){
        
        
        APIManager.conversion(params: params, onSuccess: { (response) in
            
            guard let jsonArray = response as? [String: Any],
                let rates = jsonArray["rates"] as? [String: Any] else {
                return
            }
            
            let values = Values(amount: "\(jsonArray["amount"] as? Int ?? 0)",
                                to: rates.first?.key ?? "",
                                from: jsonArray["base"] as? String ?? "",
                                converted: "\(rates.first?.value as? Double ?? 0.0)",
                                date: jsonArray["date"] as? String ?? "")
            conversionBlock(values)
            
        }) { (error) in
            
            print(error)
        }
    }
}
