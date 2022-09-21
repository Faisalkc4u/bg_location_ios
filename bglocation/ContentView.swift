//
//  ContentView.swift
//  bglocation
//
//  Created by Faisal on 15/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
       
        Button(action: onLocation)
        {
            Text("Click")
        }
}
}
func onLocation()->Void{
    print("Started")
    DataStorage.setKey(keyValue: "upload_url", storeValue: "https://api.b-seenapp.com/driver/uploadLocations")
    DataStorage.setKey(keyValue: "auth_token", storeValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjgyMjc4NjhjZThmNTA1NTk5ODIwZDAiLCJpYXQiOjE2NjM2ODI0ODh9.FuzVONeJ_4sf5Hv7v1w0XmxVrvbBHcGxdb62AkXiLWw")

    LocationManager.shared.requestLocationAuthorization()
    LocationManager.shared.startMySignificantLocationChanges()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
