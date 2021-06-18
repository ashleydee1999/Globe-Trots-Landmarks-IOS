 //
//  ContentView.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/04/28.
//

import SwiftUI

struct ContentView: View
{

    var body: some View
    {
        ZStack
        {
            
            VStack
            {
                NavigationBarView()
                    .padding(.horizontal,15)
                    .padding(.bottom)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.05),radius: 5, x: 0, y: 5)
                
                ProvincesViewWF()
                
            }
            
            
        }.ignoresSafeArea(.all, edges: .top)
        
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
