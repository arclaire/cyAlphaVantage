//
//  VCScreen3.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import UIKit

class VCScreen3: UIViewController {
    var presenter: PScreen3?
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var btnInterval: UIButton!
    @IBOutlet var tfApiKey: UITextField!

    @IBOutlet var labelInfo: UILabel!
    @IBOutlet var btnFunctionType: UIButton!

    @IBOutlet var btnDone: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        picker.delegate = self
        picker.dataSource = self
        // Do any additional setup after loading the view.
    }

    func loadData() {
        tfApiKey.text = DataManager.shared.loadAPIKEY()
        btnInterval.setTitle(DataManager.shared.getFunctionInterval(), for: .normal)
        if DataManager.shared.isDaily {
            btnFunctionType.setTitle("Daily", for: .normal)
        } else {
            btnFunctionType.setTitle("Intraday", for: .normal)
        }

        showPicker(isHidden: true)
    }

    func showPicker(isHidden: Bool) {
        picker.reloadAllComponents()
        picker.isHidden = isHidden
        btnDone.isHidden = isHidden
        labelInfo.isHidden = isHidden
    }

    func saveAPIkey() {
        if let str = tfApiKey.text {
            if str.count > 0 {
                DataManager.shared.saveAPIKEYToKeyChain(str: str)
            }
        }
    }

    @IBAction func actionButton(_ sender: Any) {
        if let btn = sender as? UIButton {
            if btn == btnDone {
                showPicker(isHidden: true)
            }

            if btn == btnInterval {
                presenter?.isInterval = true
                showPicker(isHidden: false)
                labelInfo.text = "Please Select interval duration"
            }

            if btn == btnFunctionType {
                presenter?.isInterval = false
                showPicker(isHidden: false)
                labelInfo.text = "Please Select function type"
            }
        }
    }

    @IBAction func editingDone(_: Any) {
        saveAPIkey()
    }

    @IBAction func textValueChanged(_: Any) {}
}

extension VCScreen3: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        if presenter!.isInterval {
            return presenter!.arrInterval.count
        } else {
            return presenter!.arrType.count
        }
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        if presenter!.isInterval {
            DataManager.shared.saveInterval(str: presenter!.arrInterval[row])
            if let str = presenter?.arrInterval[row] {
                btnInterval.setTitle(str, for: .normal)
            }

        } else {
            if let str = presenter?.arrType[row] {
                if str == "Daily" {
                    DataManager.shared.saveFunctionType(str: "function=TIME_SERIES_DAILY_ADJUSTED")
                } else {
                    DataManager.shared.saveFunctionType(str: "function=TIME_SERIES_INTRADAY")
                }
                btnFunctionType.setTitle(str, for: .normal)
            }
        }
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        if presenter!.isInterval {
            return presenter!.arrInterval[row]
        } else {
            return presenter!.arrType[row]
        }
    }
}
