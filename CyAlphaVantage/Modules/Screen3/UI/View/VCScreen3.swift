//
//  VCScreen3.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import UIKit

class VCScreen3: UIViewController {
    var presenter: PScreen3?
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var btnInterval: UIButton!
    @IBOutlet weak var tfApiKey: UITextField!
    
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var btnFunctionType: UIButton!
    
    @IBOutlet weak var btnDone: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.picker.delegate = self
        self.picker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        self.tfApiKey.text = DataManager.shared.loadAPIKEY()
        self.btnInterval.setTitle(DataManager.shared.getFunctionInterval(), for: .normal)
        if DataManager.shared.isDaily {
            self.btnFunctionType.setTitle("Daily", for: .normal)
        } else {
            self.btnFunctionType.setTitle("Intraday", for: .normal)
        }
        
        self.showPicker(isHidden: true)
    }
    
    func showPicker(isHidden: Bool) {
        self.picker.reloadAllComponents()
        self.picker.isHidden = isHidden
        self.btnDone.isHidden = isHidden
        self.labelInfo.isHidden = isHidden
        
    }
    
    func saveAPIkey() {
        if let str = self.tfApiKey.text {
            if str.count > 0 {
                DataManager.shared.saveAPIKEYToKeyChain(str: str)
            }
        }
    }
    
    @IBAction func actionButton(_ sender: Any) {
        if let btn = sender as? UIButton {
            if btn == self.btnDone {
                self.showPicker(isHidden: true)
            }
            
            if btn == self.btnInterval {
                self.presenter?.isInterval = true
                self.showPicker(isHidden: false)
                self.labelInfo.text = "Please Select interval duration"
            }
            
            if btn == self.btnFunctionType {
                self.presenter?.isInterval = false
                self.showPicker(isHidden: false)
                self.labelInfo.text = "Please Select function type"
            }
        }
        
    }
    
    @IBAction func editingDone(_ sender: Any) {
        self.saveAPIkey()
    }
    
    @IBAction func textValueChanged(_ sender: Any) {
        
    }
    
}

extension VCScreen3: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.presenter!.isInterval {
            return self.presenter!.arrInterval.count
        } else {
            return self.presenter!.arrType.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.presenter!.isInterval {
            DataManager.shared.saveInterval(str: self.presenter!.arrInterval[row])
            if let str = self.presenter?.arrInterval[row] {
                self.btnInterval.setTitle(str, for: .normal)
            }
            
        } else {
            if let str = self.presenter?.arrType[row] {
                if str == "Daily" {
                    DataManager.shared.saveFunctionType(str: "function=TIME_SERIES_DAILY_ADJUSTED")
                } else {
                    DataManager.shared.saveFunctionType(str: "function=TIME_SERIES_INTRADAY")
                }
                self.btnFunctionType.setTitle(str, for: .normal)
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.presenter!.isInterval {
            return self.presenter!.arrInterval[row]
        } else {
            return self.presenter!.arrType[row]
        }
    }
    
}
