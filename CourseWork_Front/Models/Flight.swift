//
//  Flight.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 12.05.2021.
//

import Foundation
struct Flight: Identifiable, Encodable{
	var id: Int64?
	var flightName: String?
	var planeId: String?
	var prevFlightName: String?//коннекшн с предыдущим полетом
	var startTime: TimeInterval?
	var endTime: TimeInterval?
	var planeModel: String?
	var startCountry: String?
	var endCountry: String?
	var startCity: String?
	var endCity: String?
	var passengersAmount: Int?
	var seatsNumbers: [Int]?
	var seatsFullNames: [String]?
	var personnelIds: [Int64]?
	var baggageIds: [Int64]?
}
