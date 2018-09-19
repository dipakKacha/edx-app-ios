//
//  CategoryAPI.swift
//  edX
//
//  Created by Quixom Technology on 12/09/18.
//  Copyright © 2018 edX. All rights reserved.
//

import UIKit
import edXCore

struct CategoryAPI {
    public typealias Environment =  OEXAnalyticsProvider & OEXConfigProvider & OEXSessionProvider & OEXStylesProvider & ReachabilityProvider
    private let environment: Environment
    
    typealias CompletionHandler = (AllCategories) -> ()
    static func getAllCategories(completionHandler:@escaping CompletionHandler) {
        let url = URL(string: "\(String(describing: OEXConfig.shared().apiHostURL()!))/all_categories")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            let convertedString = String(data: unwrappedData, encoding: String.Encoding.utf8) // the data will be converted to the string
            
            let result = Mapper<AllCategories>().map(JSONString: convertedString!)
            completionHandler(result!)
        }
        task.resume()
    }
    
    typealias PromotionalCoursesCompletionHandler = (PromotionalCourses) -> ()
    static func getPromotionalCourses(completionHandler:@escaping PromotionalCoursesCompletionHandler) {
        let url = URL(string: "\(String(describing: OEXConfig.shared().apiHostURL()!))/promotional_courses/")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            let convertedString = String(data: unwrappedData, encoding: String.Encoding.utf8) // the data will be converted to the string
            
            let result = Mapper<PromotionalCourses>().map(JSONString: convertedString!)
            if result != nil {
                completionHandler(result!)
            } else {
                print (convertedString as Any)
            }
        }
        task.resume()

    }
}
