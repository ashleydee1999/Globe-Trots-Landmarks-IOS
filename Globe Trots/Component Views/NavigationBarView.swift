//
//  NavigationBarView.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/05/02.
//

import SwiftUI

struct NavigationBarView: View
{
    @State private var isAnimated: Bool = false
    
    var body: some View
    {
        HStack
        {
            Spacer()
            
            LogoView()
                .opacity(isAnimated ? 1:  0)
                .offset(x: 0, y: isAnimated ? 0 : -25)
                .onAppear(perform: {
                    withAnimation(.easeOut(duration: 0.5))
                    {
                        isAnimated.toggle()
                    }
                })
            
            Spacer()
        }
       
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
