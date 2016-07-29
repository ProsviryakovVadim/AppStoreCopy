//
//  AppCategory.swift
//  AppStoreCopy
//
//  Created by Vadim on 24.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class FeaturedApps: NSObject {
    var bannerCategory: AppCategory?
    var appCategories: [AppCategory]?
    
    override func setValue(value: AnyObject?, forKey key: String) {
       
        if key == "categories" {
            appCategories = [AppCategory]()
            for dict in value as! [[String: AnyObject]]{
                let app = AppCategory()

                app.setValuesForKeysWithDictionary(dict)
                appCategories?.append(app)
            }
            
        } else if key == "bannerCategory" {
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeysWithDictionary(value as! [String: AnyObject])
            
        }else {
            super.setValue(value, forKey: key)
        }
    }
}


class AppCategory: NSObject {
    var name: String?
    var apps: [App]?
    var type: String?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "apps" {
            apps = [App]()
            for dict in value as! [[String: AnyObject]] {
                let app = App()
                app.setValuesForKeysWithDictionary(dict)
                apps?.append(app)
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    
    static func fetchFeaturedApps(completionHandler: (FeaturedApps)->()) {
        
        let urlString = "http://www.statsallday.com/appstore/featured"
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    
                    do {
                        let json = try (NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
                        
                        let featuredApps = FeaturedApps()
                        featuredApps.setValuesForKeysWithDictionary(json as! [String: AnyObject])
                        
                        //                        var appCategories = [AppCategory]()
                        //                        for dict in json["categories"] as! [[String: AnyObject]] {
                        //                            let appCategory = AppCategory()
                        //                            appCategory.setValuesForKeysWithDictionary(dict)
                        //                            appCategories.append(appCategory)
                        //                        }
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            completionHandler(featuredApps)
                        })
                        
                    } catch let err as NSError {
                        print(err.localizedDescription)
                    }
                }
            }
            }.resume()
    }
    
    //    static func sampleAppCategories() -> [AppCategory] {
    //
    //        let bestNewAppCategory = AppCategory()
    //        bestNewAppCategory.name = "Best New Apps"
    //
    //        let bestNewGamesCategory = AppCategory()
    //        bestNewGamesCategory.name = "Best New Games"
    //
    //        var bestNewApps = [App]()
    //        var bestNewGamesApps = [App]()
    //
    //        let frozenApp = App()
    //        frozenApp.name = "Disney Build It: Frozen"
    //        frozenApp.imageName = "frozen"
    //        frozenApp.category = "Entertainment"
    //        frozenApp.price = NSNumber(float: 3.99)
    //        bestNewApps.append(frozenApp)
    //        bestNewAppCategory.apps = bestNewApps
    //
    //        let telepaintApp = App()
    //        telepaintApp.name = "Telepaint"
    //        telepaintApp.imageName = "telepaint"
    //        telepaintApp.category = "Games"
    //        telepaintApp.price = NSNumber(float: 2.99)
    //        bestNewGamesApps.append(telepaintApp)
    //        bestNewGamesCategory.apps = bestNewGamesApps
    //
    //        return [bestNewAppCategory, bestNewGamesCategory]
    //
    //    }
    
}

class App: NSObject {
    var id: NSNumber?
    var imageName: String?
    var name: String?
    var category: String?
    var price: NSNumber?
    
    var screenshots: [String]?

}