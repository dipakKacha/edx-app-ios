
import Foundation

struct PromoCourseMedia : Mappable {
	var image : [String]?
	var course_video : Course_video?
	var course_image : Course_image?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		image <- map["image"]
		course_video <- map["course_video"]
		course_image <- map["course_image"]
	}

}
