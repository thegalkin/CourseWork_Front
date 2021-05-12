//
//  Employee.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 12.05.2021.
//

import Foundation

public struct Employee: Encodable{
	var id: Int64?
	var name: String?
	var secondname: String?
	var lastname: String?
	var licenses: [String]?
	var role: String?
	var countryoforigin: String?
	var visas: [String]?
}
