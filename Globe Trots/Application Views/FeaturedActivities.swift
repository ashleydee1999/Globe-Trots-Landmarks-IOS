
import SwiftUI

struct ActImageOverlay: View
{
    var activityLength:String
    
    var body: some View
    {
        ZStack
        {
            HStack
            {
                Image("distance")
                    .resizable()
                    .frame(width:30, height: 30)
                    .padding(5)
                    .padding(.leading,-5)
                
                Text(activityLength.uppercased())
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(5)
            }
            
        }
        .background(Color.black)
        .opacity(0.7)
        .cornerRadius(12)
        .padding(10)
    }
}

struct ActView: View
{
    let actImg: String
    let actLength: String
    let actName: String
    let actCat: String
    
    var body: some View
    {
        
        if (actName.isEmpty || actName == "")
        {
            NothingToShow()
        }
        else
        {
            VStack
                {
                    Image(actImg)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                        .cornerRadius(7)
                        .overlay(ActImageOverlay(activityLength: actLength), alignment: .bottomLeading)
                    
                    HStack
                    {
                        VStack (alignment: .leading, spacing: 5)
                        {
                            Text(actName)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.top,-15)
                            
                            
                           HStack
                            {
                            
                                if actCat == "Hiking"
                                {
                                    Image("hike")
                                        .resizable()
                                        .frame(width:20, height: 20)
                                }
                                else if actCat == "Drive"
                                {
                                    Image("bus")
                                        .resizable()
                                        .frame(width:20, height: 20)
                                }
                                else
                                {
                                    Image("bicycle")
                                        .resizable()
                                        .frame(width:20, height: 20)
                                }
                            
                                
                                Text(actCat)
                                    .foregroundColor(.secondary)
                                    .lineLimit(3)
                            }
                            
                        }.padding()
                
                    }
                    
                }
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.gray), lineWidth: 1))
                .padding()
        }
  
    }
}

struct NothingToShow: View
{
    var body: some View
    {
        HStack
        {
            Image("nothing")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            Text("There are currently no activies on record.")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black)
                .padding()
        }
        .frame(width: 300, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color(.gray))
        .cornerRadius(7)
    }
}

struct FeaturedActivities: View
{
   
    @ObservedObject var datas = Json2(jSONfile: "landmarksActivities")
    
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
                    
                    ActView(actImg: item.actImg, actLength: item.actLength, actName: item.actName, actCat: item.actCat)
                
                }
            
           }
           .padding(.all, 5)
           }.frame(height: 220)
        
        
    }
}

struct FeaturedActivities_Previews: PreviewProvider
{
    static var previews: some View
    {
        FeaturedActivities(theLandmark: "Pilanesberg National Park")
                       
    }
}
