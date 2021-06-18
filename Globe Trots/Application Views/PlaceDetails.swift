//
//  CardView.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/04/28.
//

import SwiftUI
//addFavourite(titleValue: String, imageValue: String, cityValue: String, descValue: String, phoneValue: String, theLonValue: String, theLatValue: String, Value: String)
struct TheFavouritesButton: View
{
    var image:String
    var title: String
    var city: String
    var desc: String
    var phone: String
    var theLon: String
    var theLat: String
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    
    var body: some View
    {
        Button(action:
        {
            let checkIfExists = DB_Manager().getFavouriteLandmarks(landName: title)
            
            if checkIfExists == true
            {
                print("Item Exists")
                showingAlert2 = true
            }
            else
            {
                DB_Manager().addFavourite(titleValue: title, imageValue: image, cityValue: city, descValue: desc, phoneValue: phone, theLonValue: theLon, theLatValue: theLat)
                showingAlert = true
            }
            
        }, label:
            
        {
            Image(systemName: "heart")
                .font(.system(.title2))
                .frame(width: 37, height: 30)
                .foregroundColor(Color.white)
                .padding(5)
        })
        .background(Color.green)
        .cornerRadius(38.5)
        .shadow(color: Color.black.opacity(0.3),
                radius: 3,
                x: 3,
                y: 3)
        .alert(isPresented: $showingAlert)
        {
            Alert(title: Text("Favourite Landmark"),
            message: Text("Landmark added to favourites!"),
            dismissButton: .default(Text("Got it!")))
        }
            .alert(isPresented: $showingAlert2)
            {
                Alert(title: Text("Favourite Landmark"),
                message: Text("Landmark Exists"),
                dismissButton: .default(Text("Got it!")))
            }
    }
}

struct PlaceDetails: View
{
    var image:String
    var title: String
    var city: String
    var desc: String
    var phone: String
    var theLon: String
    var theLat: String
    
    var body: some View
    {
        ScrollView
        {
            VStack
            {
                
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                
                HStack
                {
                    VStack (alignment: .leading, spacing: 5)
                    {
                        Text(title)
                            .font(.title)
                            .fontWeight(.black)
                        
                        Text(city)
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text(phone)
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        
                        Text(desc)
                            .foregroundColor(.secondary)
                        
                        HStack
                        {
                            NavigationLink(destination: MapView(lat: .constant(Double(theLat)!), lon: .constant(Double(theLon)!)))
                            {
                                HStack
                                {
                                    Image(systemName: "map")
                                        .foregroundColor(.green)
                                    
                                    Text("View Map")
                                        .foregroundColor(.green)
                                }
                            }
                            Spacer()
                            
                            TheFavouritesButton(image: image, title: title, city: city, desc: desc, phone: phone, theLon: theLon, theLat: theLat)
                        }
                        
                        
                    }.padding()
                    
                    Spacer()
                }
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.gray), lineWidth: 1))
                .padding()
            }
            
            
            VStack(alignment: .leading, spacing: 5)
            {
                
                Text("Activities")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.black)
                    .padding()
                    .padding(.bottom,-20)
                
                FeaturedActivities(theLandmark: title)
                  
                
                Text("Restaurants Nearby")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.black)
                    .padding()
                    .padding(.top,-20)
                    .padding(.bottom,-20)
                
                FeaturedRestaurants(theLandmark: title)
                
            }
            .padding(.top,-25)
            
        }
        
    }
}

struct PlaceDetails_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetails(image: "province", title: "Gauteng", city: "Johannesburg", desc: "bdbjhdcb ehbjbe uehwkceb", phone: "011 378 8378", theLon: "1", theLat: "1")
    }
}
