//
//  CategoryAPI.swift
//  edX
//
//  Created by Quixom Technology on 12/09/18.
//  Copyright © 2018 edX. All rights reserved.
//

import UIKit
import edXCore

func jsonToString(json: AnyObject) -> String{
    do {
        let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
        let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
        print(convertedString ?? "defaultvalue")
        return convertedString!
    } catch let myJSONError {
        print(myJSONError)
        return ""
    }
    
}
struct CategoryAPI {
    
    static func enrollmentsDeserializer(response: HTTPURLResponse, json: JSON) -> Result<AllCategories> {
        print(json)
        // Convert JSON String to Model
        let JSONString = jsonToString(json: json as AnyObject)
        let user = Mapper<AllCategories>().map(JSONString: JSONString)
        return user.toResult()
//        return (json.array?.flatMap { UserCourseEnrollment(json: $0) }).toResult()
    }
    
    static func getAllCategories()  {
        let path = "all_categories"
        print(NetworkRequest(
            method: .GET,
            path: path,
            requiresAuth: true,
            deserializer: .jsonResponse(enrollmentsDeserializer))
        )
    }
    
//    static func allCoursesDeserializer(response: HTTPURLResponse, json: JSON) -> Result<[UserCourseEnrollment]> {
//        return (json.array?.flatMap { UserCourseEnrollment(json: $0) }).toResult()
//    }
//
//    static func getAllCourses() -> NetworkRequest<[UserCourseEnrollment]> {
//        let path = "api/courses/v1/courses/"
//
//        return NetworkRequest(method: .GET,
//                              path: path,
//                              requiresAuth: true,
//                              deserializer: .jsonResponse(enrollmentsDeserializer))
//    }
}
