
import Foundation

struct AllCategories : Mappable {
	var results : [CatResult]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		results <- map["results"]
	}

}
