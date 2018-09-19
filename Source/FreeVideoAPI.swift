//
//  FreeVideoAPI.swift
//  edX
//
//  Created by Quixom Technology on 17/09/18.
//  Copyright © 2018 edX. All rights reserved.
//

import UIKit

struct FreeVideoAPI {

    public typealias Environment =  OEXAnalyticsProvider & OEXConfigProvider & OEXSessionProvider & OEXStylesProvider & ReachabilityProvider
    private let environment: Environment
    
    typealias CompletionHandler = (GetFreeVideos) -> ()
    static func getFreeVideos(courseId:String, completionHandler:@escaping CompletionHandler) {
        let url = URL(string: "\(String(describing: OEXConfig.shared().apiHostURL()!))/api/course/\(courseId)/free_videos")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            let convertedString = String(data: unwrappedData, encoding: String.Encoding.utf8) // the data will be converted to the string
            
            let result = Mapper<GetFreeVideos>().map(JSONString: convertedString!)
            completionHandler(result!)
        }
        task.resume()
    }
}
