//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Vijith T.V on 31/03/19.
//  Copyright © 2019 Vijith T.V. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var toCurrency: UIButton!
    @IBOutlet weak var fromCurrency: UIButton!
    
    var isTo: Bool = false
    var isToField: Bool = false
    var toSymbol: String = "USD"
    var fromSymbol: String = "INR"
    
    var currencies = [Currencies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initVC()
    }
    
    /// Initial method
    private func initVC() {
        
        APIHandler.currencyValues { (currencies) in
            self.currencies = currencies
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
        }
        
    }
    
    
    /// Get currency values
    ///
    /// - Parameter params: API parameters
    private func getValue(params: [String: String]) {
        
        APIHandler.conversion(params: params, conversionBlock: { (values) in
            
            DispatchQueue.main.async {
                
                if self.isToField {
                    self.fromField.text = values.convertedAmount
                } else {
                    self.toField.text = values.convertedAmount
                }
            }
            
        })
        
    }
    
    /// To currency button action
    ///
    /// - Parameter sender: Any
    @IBAction func toAction(_ sender: Any) {
        
        pickerView.isHidden = false
        self.view.endEditing(true)
        isTo = true
        
    }
    
    /// From currency button action
    ///
    /// - Parameter sender: Any
    @IBAction func fromAction(_ sender: Any) {
        
        isTo = false
        pickerView.isHidden = false
        self.view.endEditing(true)
    }

    /// Text field editing changes
    ///
    /// - Parameter sender: UITextfield
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        
        var params: [String: String] = [:]
        
        if sender.tag == 1 {
            isToField = true
            params = [
                "amount" : sender.text ?? "",
                "from" : toCurrency.titleLabel?.text ?? "",
                "to" : fromCurrency.titleLabel?.text ?? "",
                ]
        } else {
            isToField = false
            params = [
                "amount" : sender.text ?? "",
                "from" : fromCurrency.titleLabel?.text ?? "",
                "to" : toCurrency.titleLabel?.text ?? "",
                ]
        }
        if params["amount"] == "" && isToField {
            fromField.text = "0.0"
        } else if params["amount"] == "" && !isToField {
            toField.text = "0.0"
        }
        getValue(params: params)
    }
    
    /// Touches began
    ///
    /// - Parameters:
    ///   - touches: Touch event
    ///   - event: UIEvent
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension ConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - Pickerview method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return currencies[row].fullName
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        let curr = self.currencies[row].symbol
        isTo == false ? fromCurrency.setTitle(curr, for: .normal) : toCurrency.setTitle(curr, for: .normal)
        self.pickerView.isHidden = true
        
    }
    
}
