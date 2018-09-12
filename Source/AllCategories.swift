
import Foundation

struct AllCategories : Mappable {
	var result : [CatResult]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		result <- map["result"]
	}

}
