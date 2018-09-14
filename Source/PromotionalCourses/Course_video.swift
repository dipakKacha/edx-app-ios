import Foundation

struct Course_video : Mappable {
	var uri : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		uri <- map["uri"]
	}

}
