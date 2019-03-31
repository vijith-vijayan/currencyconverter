//
//  ConvertedValue.swift
//  CurrencyConverter
//
//  Created by Vijith T.V on 31/03/19.
//  Copyright © 2019 Vijith T.V. All rights reserved.
//

import Foundation

class Values {
    
    var from: String
    var to: String
    var amount: String
    var convertedAmount: String
    var date: String
    
    /// Values Class initializer
    ///
    /// - Parameters:
    ///   - amount: Amount
    ///   - to: To Currency
    ///   - from: From Currencey
    ///   - converted: Converted amount
    ///   - date: Date of conversion
    
    init(amount: String,
         to: String, from: String,
         converted: String, date: String) {
        
        self.amount = amount
        self.to = to
        self.from = from
        self.amount = amount
        self.convertedAmount = converted
        self.date = date
    }
    
}
