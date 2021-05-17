//
//  Plane.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 12.05.2021.
//

import Foundation

public struct Plane: Encodable{
//	var id: Int64?
	var internationalNumber: String?
	var russianNumber: String?
	var boardName: String?
	var model: String?
	var repairHistory: [String]?
	var ownerCompany: String?
	var humanCapacity: Int?
	var personnelCapacity: Int?
	var baggageCapacity: Int?
	var flightHistory: [Int64]?
}
