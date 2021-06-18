//
//  FeaturedRestaurants.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/05/13.
//

import SwiftUI

struct RatingOverlay: View
{
    var restaurantRating:String
    
    var body: some View
    {
        ZStack
        {
            HStack
            {
                
                Text(restaurantRating.uppercased())
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(5)
                
                Image("star")
                    .resizable()
                    .frame(width:25, height: 25)
                    .padding(5)
                    .padding(.leading,-7)
            }
            
        }
        .background(Color.yellow)
        .opacity(0.7)
        .cornerRadius(12)
        .padding(10)
    }
}

struct RestView: View
{
    let restImg: String
    let restDistance: String
    let restName: String
    let restRating: String
    let restaurantCat: String
    
    var body: some View
    {
        VStack
            {
                Image(restImg)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
                    .cornerRadius(7)
                    .overlay(RatingOverlay(restaurantRating: restRating), alignment: .topTrailing)
                
                HStack
                {
                    VStack (alignment: .leading, spacing: 5)
                    {
                        Text(restName)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top,-15)
                        
                        
                       HStack
                        {
                        
                            if restaurantCat == "outdoor"
                            {
                                Image("outdoor")
                                    .resizable()
                                    .frame(width:20, height: 20)
                            }
                            else
                            {
                                Image("diner")
                                    .resizable()
                                    .frame(width:20, height: 20)
                            }
                        
                            
                        Text(restaurantCat.uppercased())
                                .foregroundColor(.secondary)
                                .lineLimit(3)
                        }
                        
                        Text(restDistance)
                            .foregroundColor(.secondary)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top,2)
                           
                        
                    }.padding()
            
                }
                
            }
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.gray), lineWidth: 1))
            .padding()
    }
}
struct FeaturedRestaurants: View
{
    @ObservedObject var datas = Json3(jSONfile: "landmarksRestaurants")
    var theLandmark: String
    
    var hGridLayout =
        [
            GridItem(.flexible(maximum: 100))
        ]
    
    var body: some View
    {
        
        ScrollView(.horizontal)
        {
           
           LazyHGrid(rows: hGridLayout)
           {
              
                ForEach(datas.json.filter{$0.landMarkName == theLandmark})
                {
                    
                    item in
                    
                   
                    RestView(restImg: item.restaurantImg, restDistance: item.restaurantDistance, restName: item.restaurantName, restRating: item.restaurantRating, restaurantCat: item.restaurantCat)
                        
                }
            
            
           }
           .padding(.all, 5)
       }.frame(height: 220)
    }
}

struct FeaturedRestaurants_Previews: PreviewProvider
{
    
    static var previews: some View
    {
        FeaturedRestaurants(theLandmark: "Pilanesberg National Park")
    }
}
