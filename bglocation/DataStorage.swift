//
//  DataStorage.swift
//  bglocation
//
//  Created by Faisal on 20/09/2022.
//

import Foundation
class DataStorage{
    static let shared = DataStorage();
    
    public static func setKey( keyValue : String, storeValue : String){
        UserDefaults.standard.set(  storeValue, forKey: keyValue)
    }
    public static func getKey( keyValue : String) -> String? {
      return  UserDefaults.standard.string(forKey: keyValue)
    }
    public static func handleArgs(parms : Dictionary<String, Any>?){
       
       if (parms != nil &&  ((parms!["auth_token"] as? String) != nil) && ( parms!["upload_url"] as? String) != nil)
        {
           setKey(keyValue: "auth_token", storeValue: parms!["auth_token"] as! String )
           setKey(keyValue: "upload_url", storeValue: parms!["upload_url"] as! String)
       }

    }
}
