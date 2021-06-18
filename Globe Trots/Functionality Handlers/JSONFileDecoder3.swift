//
//  JSONFileDecorder.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/05/10.
//

import Foundation

struct Model3: Codable, Identifiable, Hashable
{
    enum CodingKeys: CodingKey
    {
        case landMarkName
        case restaurantName
        case restaurantImg
        case restaurantRating
        case restaurantDistance
        case restaurantCat
    }
    
    let id=UUID()
    let landMarkName: String
    let restaurantName: String
    let restaurantImg: String
    let restaurantRating: String
    let restaurantDistance: String
    let restaurantCat: String
}

public class Json3: ObservableObject
{
    let jSONfile: String
    
    @Published var json = [Model3]()
    
    init(jSONfile: String)
    {
        
        self.jSONfile = jSONfile
        load(fileName: jSONfile)
    }
    
    func load(fileName: String)
    {

        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            do
            {
                if let data = data
                {
                    let json = try JSONDecoder().decode([Model3].self, from: data)
                    DispatchQueue.main.sync
                    {
                        self.json = json
                    }
                }
                else
                {
                    print("no data")
                }

                
            }
            catch
            {
                print(error)
            }
        }.resume()
    }
}
