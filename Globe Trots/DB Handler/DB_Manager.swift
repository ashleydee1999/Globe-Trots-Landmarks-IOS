//
//  DB_Manager.swift
//  Globe Trots
//
//  Created by IACD-Air-11 on 2021/05/13.
//

import Foundation

import SQLite
 
class DB_Manager
{
     
    // sqlite instance
    private var db: Connection!
     
    // table instance
    private var favouriteLandmarks: Table!
 
    // columns instances of table
    private var id: Expression<Int64>!
    private var title: Expression<String>!
    private var image: Expression<String>!
    private var city: Expression<String>!
    private var desc: Expression<String>!
    private var phone: Expression<String>!
    private var theLon: Expression<String>!
    private var theLat: Expression<String>!
     
    // constructor of this class
    init () {
         
        // exception handling
        do {
             
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
 
            // creating database connection
            db = try Connection("\(path)/my_users.sqlite3")
             
            // creating table object
            favouriteLandmarks = Table("FavouriteLandmarks")
             
            // create instances of each column
            id = Expression<Int64>("id")
            title = Expression<String>("title")
            image = Expression<String>("image")
            city = Expression<String>("city")
            desc = Expression<String>("desc")
            phone = Expression<String>("phone")
            theLon  = Expression<String>("theLon")
            theLat = Expression<String>("theLat")
            
             
            // check if the user's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
 
                // if not, then create the table
                try db.run(favouriteLandmarks.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(title)
                    t.column(image)
                    t.column(city)
                    t.column(desc)
                    t.column(phone)
                    t.column(theLon)
                    t.column(theLat)
                })
                 
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
             
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
         
    }
    
    
    public func addFavourite(titleValue: String, imageValue: String, cityValue: String, descValue: String, phoneValue: String, theLonValue: String, theLatValue: String)
    {
        do
        {
            try db.run(favouriteLandmarks.insert(title <- titleValue, image <- imageValue, city <- cityValue, desc <- descValue, phone <- phoneValue, theLon <- theLonValue, theLat <- theLatValue))
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    // return array of user models
    public func getUsers() -> [LandMarksModel]
    {
         
        // create empty array
        var userModels: [LandMarksModel] = []
     
        // get all users in descending order
        favouriteLandmarks = favouriteLandmarks.order(id.desc)
     
        // exception handling
        do {
     
            // loop through all users
            for user in try db.prepare(favouriteLandmarks)
            {
     
                // create new model in each loop iteration
                let userModel: LandMarksModel = LandMarksModel()
     
                // set values in model from database
                userModel.id = user[id]
                userModel.title = user[title]
                userModel.image = user[image]
                userModel.city = user[city]
                userModel.desc = user[desc]
                userModel.phone = user[phone]
                userModel.theLon = user[theLon]
                userModel.theLat = user[theLat]
                
                // append in new array
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return userModels
    }
    
    //Check if favourite landmark has been added
    public func getFavouriteLandmarks(landName: String) -> Bool
    {
       var x: Int = 0
         
        // create empty array
        var userModels: [LandMarksModel] = []
     
        // get all users in descending order
        favouriteLandmarks = favouriteLandmarks.order(id.desc)
     
        // exception handling
        do {
     
            // loop through all users
            //List(datas.json.filter{$0.provinceName == theProvince})
           for user in try db.prepare(favouriteLandmarks)
            {
     
                // create new model in each loop iteration
                let userModel: LandMarksModel = LandMarksModel()
                if user[title] == landName
                {
                    x = x + 1
                }
                // set values in model from database
                userModel.id = user[id]
                userModel.title = user[title]
                userModel.image = user[image]
                userModel.city = user[city]
                userModel.desc = user[desc]
                userModel.phone = user[phone]
                userModel.theLon = user[theLon]
                userModel.theLat = user[theLat]
                
                // append in new array
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return true for value found
        if x > 0
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    // function to delete user
    public func deleteUser(idValue: Int64) {
        do {
            // get user using ID
            let user: Table = favouriteLandmarks.filter(id == idValue)
             
            // run the delete query
            try db.run(user.delete())
        } catch {
            print(error.localizedDescription)
        }
    }

}

