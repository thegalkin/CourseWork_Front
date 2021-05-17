//
//  EmployeeView.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 15.05.2021.
//

import SwiftUI
import SwiftyJSON

struct EmployeeView: View {
	var db: JSON
    var body: some View {
		NavigationLink(destination: EmployeeDetails(db: db)){
			LazyHStack{
				Text(String(db["id"].int64Value))
				Text(db["name"].string ?? "Имя")
				Text(db["secondname"].string ?? "Фамилия")
				Text(db["lastname"].string ?? "Отчество")
			}
		}
    }
}
struct EmployeeDetails: View{
	var db: JSON
	var body: some View{
		LazyVStack{
			LazyHStack{
				Text(String(db["id"].int64Value))
				Text(db["name"].string ?? "Имя")
				Text(db["secondname"].string ?? "Фамилия")
				Text(db["lastname"].string ?? "Отчество")
			}
			if let licenses = db["licenses"]{
				Text("Лицензии:")
				ForEach(0..<licenses.count){ i in
					Text("  \(licenses.arrayValue[i].stringValue)")
				}
			}else{
				Text("Лицензии отсутствуют")
			}
			Text(db["role"].string ?? "Роль")
			Text(db["countryoforigin"].string ?? "Страна происхождения")
			if let visas = db["visas"]{
				Text("Визы:")
				ForEach(0..<visas.count){ i in
					Text("  \(visas.arrayValue[i].stringValue)")
				}
			}else{
				Text("Визы отсутствуют")
			}
			
		}
	}
}
