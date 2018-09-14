
import Foundation

struct Course_image : Mappable {
	var uri : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		uri <- map["uri"]
	}

}
