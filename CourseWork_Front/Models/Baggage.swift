//
//  Baggage.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 12.05.2021.
//

import Foundation

public struct Baggage: Encodable{
	var id: Int64?
	var ownerFullName: String?
	var flightId: Int64?
	var targetFlightName: String?
	var startCountry: String?
	var middleCountries: [String]?
	var endCountry: [String]?
}
