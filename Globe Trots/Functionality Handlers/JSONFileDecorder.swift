//
//  JSONFileDecorder.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/05/10.
//

import Foundation

struct Model: Codable, Identifiable, Hashable
{
    enum CodingKeys: CodingKey
    {
        case provinceName
        case provinceImg
        case landMarkName
        case landMarkImg
        case phone
        case city
        case description
        case latitude
        case longitude
    
    }
    
    let id=UUID()
    let provinceName: String
    let provinceImg: String
    let landMarkName: String
    let landMarkImg: String
    let phone: String
    let city: String
    let description: String
    let latitude: String
    let longitude: String
    
}

public class Json: ObservableObject
{
    let jSONfile: String
    
    @Published var json = [Model]()
    
    init(jSONfile: String)
    {
        
        self.jSONfile = jSONfile
        load(fileName: jSONfile)
    }
    
    func load(fileName: String)
    {

        //let path = Bundle.main.path(forResource: "provincialLandmarks", ofType: "json")
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            do
            {
                if let data = data
                {
                    let json = try JSONDecoder().decode([Model].self, from: data)
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
