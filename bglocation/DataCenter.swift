//
//  DataCenter.swift
//  bglocation
//
//  Created by user on 16/09/2022.
//

import Foundation
import CoreLocation
import UIKit
class DataCenter{
    
    public func  sendLocations(_ latitude:String ,_ longitude : String ,bgMode:Bool){
        
        guard let url =  DataStorage.getKey(keyValue: "upload_url") else{
            return ;
        }
        let authToken : String? = DataStorage.getKey(keyValue: "auth_token")
        var json = [String:Any]()
        var cord = [String:Any]()
        cord["longitude"]=longitude
        cord["latitude"]=latitude
        if(bgMode)
        {
            cord["mode"] = "B"
        }
        else{
            cord["mode"] = "F"
        }
        
        json["location_points_long_lat"] = [cord]
        
        
        do {
             let data = try JSONSerialization.data(withJSONObject: json, options: [])
            var request = URLRequest(url: URL(string: url)!)
            request.addValue((authToken ?? "")!, forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request)
            task.resume()
            print("API call completed ".appending(url))
         }catch{
            print("There is netowrk Error")
        }
        
    }
}
