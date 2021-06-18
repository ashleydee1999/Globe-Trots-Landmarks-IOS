//
//  MainView.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/05/13.
//

import SwiftUI

struct MainView: View
{
    var body: some View
    {
        TabView
        {
            ContentView()
                .tabItem
                {
                   Label("Menu", systemImage: "homepod.2.fill")
                    
                }
            
            FavouriteLandmarksView()
                .tabItem
                {
                   Label("Favourites", systemImage: "list.dash")
                    
                }
        }
    }
}

struct MainView_Previews: PreviewProvider
{
    static var previews: some View
    {
        MainView()
    }
}
