//
//  Currencies.swift
//  CurrencyConverter
//
//  Created by Vijith T.V on 31/03/19.
//  Copyright © 2019 Vijith T.V. All rights reserved.
//

import Foundation

class Currencies {
    
    /// Variabels
    
    var symbol: String
    var fullName: String
    
    /// Currency Initializer
    ///
    /// - Parameters:
    ///   - symbol: Symbol of currency
    ///   - fullName: Name of currency
    
    init(symbol: String, fullName: String) {
        
        self.symbol = symbol
        self.fullName = fullName
    }
    
}
