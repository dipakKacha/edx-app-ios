import Foundation

struct Pagination : Mappable {
	var count : Int?
	var previous : String?
	var num_pages : Int?
	var next : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		count <- map["count"]
		previous <- map["previous"]
		num_pages <- map["num_pages"]
		next <- map["next"]
	}

}
