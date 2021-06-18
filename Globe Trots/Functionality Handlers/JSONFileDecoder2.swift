//
//  JSONFileDecorder.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/05/10.
//

import Foundation

struct Model2: Codable, Identifiable, Hashable
{
    enum CodingKeys: CodingKey
    {
        case landMarkName
        case actName
        case actImg
        case actLength
        case actCat
    }
    
    let id=UUID()
    let landMarkName: String
    let actName: String
    let actImg: String
    let actLength: String
    let actCat: String
    
}

public class Json2: ObservableObject
{
    let jSONfile: String
    
    @Published var json = [Model2]()
    
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
                    let json = try JSONDecoder().decode([Model2].self, from: data)
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
