
import Foundation

struct PromoCourseResults : Mappable {
	var id : Int?
	var course_id : String?
	var display_name : String?
	var media : PromoCourseMedia?
	var position : Int?
	var is_promotional : Bool?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		course_id <- map["course_id"]
		display_name <- map["display_name"]
		media <- map["media"]
		position <- map["position"]
		is_promotional <- map["is_promotional"]
	}

}
