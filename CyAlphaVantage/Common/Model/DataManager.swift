//
//  DataManager.swift
//  CyAlphaVantage
//
//  Created by Lucy on 17/01/21.
//

import Foundation
import Security

class DataManager {
    static let shared = DataManager()
    
    var userDefault = UserDefaults.standard
    var isDaily: Bool = true
    
    func saveFunctionType (str: String) {
        userDefault.set(str, forKey: UDEFKEY_FUCTIONTYPE)
    }
    
    func saveInterval (str: String) {
        userDefault.set(str, forKey: UDEFKEY_INTERVAL)
    }
    
    func saveOutputSize (str: String) {
        userDefault.set(str, forKey: UDEFKEY_OUTPUTSIZE)
    }
    
    func getFunctionType() -> String {
        var str = "function=TIME_SERIES_INTRADAY" //function=TIME_SERIES_DAILY_ADJUSTED
        if let strdef = userDefault.string(forKey: UDEFKEY_FUCTIONTYPE) {
            str = strdef
        }
        
        if str == "function=TIME_SERIES_DAILY_ADJUSTED" {
            self.isDaily = true
        } else {
            self.isDaily = false
        }
        return str
    }
    
    func getFunctionInterval() -> String {
        // 1min, 5min, 15min, 30min, 60min
        var str = "60min"
        if let strdef = userDefault.string(forKey: UDEFKEY_INTERVAL) {
            str = strdef
        }
        return str
    }
    
    func getFunctionOutputSize() -> String {
        // compact / full
        var str = "compact"
        if let strdef = userDefault.string(forKey: UDEFKEY_OUTPUTSIZE) {
            str = strdef
        }
        return str
    }
    
    func saveAPIKEYToKeyChain(str: String) {
        let data = Data(from: str)
        let status = self.keySave(key: KEYCHAIN_APIKEY, data: data)
        print("status: ", status)
    }
    
    func loadAPIKEY() -> String {
        var strAPIKEY = "9N17L75CVNEUKV3R"
        if let receivedData = self.keyLoad(key: KEYCHAIN_APIKEY) {
            let result = receivedData.to(type: String.self)
            strAPIKEY = result
            print("result: ", result)
        }
        return strAPIKEY
    }
    
    private func keySave(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    private func keyLoad(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
        
        let swiftString: String = cfStr as String
        return swiftString
    }
}
