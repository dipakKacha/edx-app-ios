import Foundation

struct FreeVideoResults : Mappable {
	var html5_sources : [String]?
	var display_name : String?
	var block_id : String?
	var is_free : Bool?
	var youtube_id : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		html5_sources <- map["html5_sources"]
		display_name <- map["display_name"]
		block_id <- map["block_id"]
		is_free <- map["is_free"]
		youtube_id <- map["youtube_id"]
	}

}
