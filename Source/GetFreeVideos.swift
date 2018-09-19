
import Foundation

struct GetFreeVideos : Mappable {
	var results : [FreeVideoResults]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		results <- map["results"]
	}

}
