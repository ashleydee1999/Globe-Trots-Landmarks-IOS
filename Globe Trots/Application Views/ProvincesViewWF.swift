//
//  ProvincesViewWF.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/05/20.
//

import SwiftUI

struct ProvincesViewWF: View
{
    let cards: [Card] =
        [
            .init(
                provinceIMG: "gauimg",
                provinceName: "Gauteng"
            ),
            .init(
                provinceIMG: "kznimg",
                provinceName: "Kwazulu Natal"
            ),
            .init(
                provinceIMG: "lppimg",
                provinceName: "Limpopo"
            ),
            .init(
                provinceIMG: "mpimg",
                provinceName: "Mpumalanga"
            ),
            .init(
                provinceIMG: "wcimg",
                provinceName: "Western Cape"
            ),
            .init(
                provinceIMG: "ecimg",
                provinceName: "Eastern Cape"
            ),
            .init(
                provinceIMG: "fsimg",
                provinceName: "Free State"
            ),
            .init( provinceIMG: "nwimg",
                provinceName: "North West"
            ),
            .init(
                provinceIMG: "ncimg",
                provinceName: "Northern Cape"
            )
        
        ]
    
    var leftCards: [Card] {
        cards.enumerated()
            .filter { $0.offset % 2 == 0 }
            .map { $0.element }
    }

    var rightCards: [Card] {
        cards.enumerated()
            .filter {$0.offset % 2 != 0 }
            .map { $0.element }
    }
    
    var visibleLeftCards: [Card]
    {
        if cards.count % 2 != 0, cards.count != 1
        {
            let slice = ArraySlice(leftCards[0..<leftCards.count - 1])
            return Array(slice)
        }
        else
        {
            return leftCards
        }
    }
    
    var visibleRightCards: [Card]
    {
        if cards.count % 2 != 0, let lastLeftCard = leftCards.last, cards.count != 1
        {
            return rightCards + [lastLeftCard]
        }
        else
        {
            return rightCards
        }
    }
    var body: some View
    {
        
        NavigationView
        {
            ScrollView
            {
                 HStack (spacing: 16)
                 {
                     //left side
                     VStack
                     {
                         ForEach(Array(visibleLeftCards.enumerated()), id: \.element)
                         {
                             offset, card in
                             
                             NavigationLink(destination: LandMarksView(theProvince: card.provinceName)
                                             .navigationBarTitle("", displayMode: .inline)
                                             .navigationBarHidden(false)
                             )
                             {
                                 
                                 CardView(card: card)
                                     .frame(height: offset % 2 == 0 ? 320 : 200)
                             }
                           
                         }
                         Spacer()
                     }
                     
                     //right side
                     
                     VStack
                     {
                         if cards.count == 1
                         {
                             RoundedRectangle(cornerRadius: 10)
                                 .fill(Color.clear)
                         }
                         ForEach(Array(visibleRightCards.enumerated()), id: \.element)
                         {
                             offset, card in
                             
                             NavigationLink(destination: LandMarksView(theProvince: card.provinceName)
                                             .navigationBarTitle("", displayMode: .inline)
                                             .navigationBarHidden(false)
                             )
                             {
                                 CardView(card: card)
                                     .frame(height: offset % 2 != 0 ? 320 : 200)
                             }
                             
                         }
                         Spacer()
                     }
                     
                 }
                 .padding()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            //.navigationBarItems(center: Image("ecimg") )
        }
        
       
    }
}

struct Card: Hashable
{
    let provinceIMG: String
    let provinceName: String
}


struct CardView: View
{
    let card: Card
    var body: some View
    {
        GeometryReader
        {
            proxy in
            ZStack
            {
                Image(card.provinceIMG)
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).fill(Color(.gray).opacity(0.4)))
                
                Text(card.provinceName.uppercased())
                    .font(.title3)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(8)
                    .foregroundColor(.white)
            }
            
        }
       
    }
}


struct ProvincesViewWF_Previews: PreviewProvider
{
    static var previews: some View
    {
        ProvincesViewWF()
    }
}
