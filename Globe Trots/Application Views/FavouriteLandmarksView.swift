//
//  FavouriteLandmarksView.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/05/13.
//

import SwiftUI


struct FavouriteLandmarksView: View
{
    // array of favourite landmarks models
    @State var favModels: [LandMarksModel] = []
    
    @State var landSelected: Bool = false
    @State var theImage: String = ""
    @State var theTitle: String = ""
    @State var theCity: String = ""
    @State var theDesc: String = ""
    @State var thePhone: String = ""
    @State var theTheLon: String = ""
    @State var theTheLat: String = ""
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {

                //Triggered when the landSelected changes true
                NavigationLink(
                    destination: PlaceDetails(image: self.theImage, title: self.theTitle, city: self.theCity, desc: self.theDesc, phone: self.thePhone, theLon: self.theTheLon, theLat: self.theTheLat),
                    isActive: self.$landSelected)
                    {
                        EmptyView()
                    }
                
                // create list view to show all users
                List (self.favModels)
                {
                    (model) in
                 
                    
                    // show name, email and age horizontally
                    HStack
                    {
                        Text(model.title)
                            .frame(width: 120)
                        
                        Spacer()
                        
                        Button(action:
                        {
                            self.theImage = model.image
                            self.theTitle = model.title
                            self.theCity = model.city
                            self.theDesc = model.desc
                            self.thePhone = model.phone
                            self.theTheLon = model.theLon
                            self.theTheLat = model.theLat
                            self.landSelected = true
                            
                        }, label:
                            
                        {
                                Image(systemName: "eye")
                                    .font(.system(.title3))
                                    .foregroundColor(Color.red)
                                    .padding(5)
                            
                        }).buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                        
                        Button(action:
                        {
                            // create db manager instance
                            let dbManager: DB_Manager = DB_Manager()
                 
                            // call delete function
                            dbManager.deleteUser(idValue: model.id)
                 
                            // refresh the user models array
                            self.favModels = dbManager.getUsers()
                            
                        }, label:
                            
                        {
                                Image(systemName: "trash")
                                    .font(.system(.title3))
                                    .foregroundColor(Color.red)
                                    .padding(5)
                            
                        }).buttonStyle(PlainButtonStyle())
                            
                        
                        Spacer()
                    }
                }
            }
                      
        }
        .onAppear(perform: {
            self.favModels = DB_Manager().getUsers()
        })
    
    }
}

struct FavouriteLandmarksView_Previews: PreviewProvider
{
    static var previews: some View
    {
        FavouriteLandmarksView(landSelected: false, theImage: "", theTitle: "", theCity: "", theDesc: "", thePhone: "", theTheLon: "", theTheLat: "")
    }
}
