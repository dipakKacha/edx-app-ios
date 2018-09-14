
import Foundation

struct PromotionalCourses : Mappable {
	var pagination : Pagination?
	var results : [PromoCourseResults]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		pagination <- map["pagination"]
		results <- map["results"]
	}

}
