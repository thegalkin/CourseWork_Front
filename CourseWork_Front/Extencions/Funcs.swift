//
//  Funcs.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 17.05.2021.
//

import Foundation

func typeName(_ some: Any) -> String {
	return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}
