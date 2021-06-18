//
//  LandMarksView.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/04/28.
//

import SwiftUI

struct LandMarksView: View
{
    @ObservedObject var datas = Json(jSONfile: "provincialLandmarks")
    var theProvince: String
    
    var body: some View
    {
        
        VStack
        {
            //filltering the landmarks that don't share the same  province name
           List(datas.json.filter{$0.provinceName == theProvince})
             {
                 item in
                 
               
                 NavigationLink(destination: PlaceDetails(image: item.landMarkImg, title: item.landMarkName, city: item.city, desc: item.description, phone: item.phone, theLon: item.longitude, theLat: item.latitude)
                                    .navigationBarTitle("", displayMode: .inline)
                                    .navigationBarHidden(false))
                         {
                            
                            listView(landMarkIMG: item.landMarkImg, landMarkCity: item.city, landMarkName: item.landMarkName)
                         }
                 
                                 
             }
             .accentColor(Color(.brown))
            
        }
        
        
    }
}

struct LandMarksView_Previews: PreviewProvider
{
    static var previews: some View
    {
        LandMarksView(theProvince: "North West")
    }
}
