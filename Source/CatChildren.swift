
import Foundation

struct CatChildren : Mappable {
	var data : CatData?
	var id : Int?
	var children : [CatChildren]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		data <- map["data"]
		id <- map["id"]
		children <- map["children"]
	}

}
