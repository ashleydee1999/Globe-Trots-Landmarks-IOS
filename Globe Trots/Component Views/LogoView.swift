//
//  LogoView.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/05/02.
//

import SwiftUI

struct LogoView: View
{
    var body: some View
    {
        HStack(spacing: 4)
        {
            Text("Globe".uppercased())
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(Color(red: 90 / 255, green: 176 / 255, blue: 149 / 255))
                .offset(x: 10)
            
                
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width:50, height: 50, alignment: .center)
            
            Text("Trot's".uppercased())
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(Color(red: 90 / 255, green: 176 / 255, blue: 149 / 255))
                .offset(x: -10)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
