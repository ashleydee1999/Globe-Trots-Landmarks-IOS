//
//  listView.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/05/12.
//

import SwiftUI

struct listView: View
{
    let landMarkIMG: String
    let landMarkCity: String
    let landMarkName: String
    
    var body: some View
    {
        HStack
        {
            Image(landMarkIMG)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 80.0, height: 80, alignment: .center)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 5)
            {
                
                Text(landMarkName)
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Text(landMarkCity)
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                
            }
                
                /*
                .background(
                    LinearGradient(gradient: Gradient(colors: Color.gray), startPoint: .top, endPoint: .bottom)
                )*/
        }
    }
}

struct listView_Previews: PreviewProvider
{
    static var previews: some View
    {
        listView(landMarkIMG: "kznimg", landMarkCity: "CApe Town", landMarkName: "Table Mountain")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
