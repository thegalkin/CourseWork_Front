//
//  PlaneView.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 15.05.2021.
//

import SwiftUI
import SwiftyJSON

struct PlaneView: View {
	var db: JSON
    var body: some View {
		NavigationLink(destination: PlaneDetailView(db: db)){
			LazyHStack{
				Text(String(db["id"].int64Value))
				Text(db["internationalNumber"].string ?? "internationalNumber")
				Text(db["model"].string ?? "model")
			}
		}
    }
}
struct PlaneDetailView: View {
	var db: JSON
	var body: some View{
		LazyVStack{
			LazyHStack{
				Text(String(db["id"].int64Value))
				Text(db["internationalNumber"].string ?? "internationalNumber")
				Text(db["model"].string ?? "model")
			}
			Text(db["russianNumber"].string ?? "russianNumber")
			Text(db["boardName"].string ?? "boardName")
			if let repairHistory = db["repairHistory"]{
				Text("История обслуживания:")
				ForEach(0..<repairHistory.count){ i in
					Text("  \(repairHistory.arrayValue[i].stringValue)")
				}
			}else{
				Text("История обслуживания осутствует")
			}
			Text(db["ownerCompany"].string ?? "ownerCompany")
			Text(db["humanCapacity"].string ?? "humanCapacity")
			Text(db["personnelCapacity"].string ?? "personnelCapacity")
			Text(db["baggageCapacity"].string ?? "baggageCapacity")
			if let flightHistory = db["flightHistory"]{
				Text("История полетов:")
				ForEach(0..<flightHistory.count){ i in
					Text("  \(flightHistory.arrayValue[i].stringValue)")
				}
			}else{
				Text("История полетов осутствует")
			}
		}
	}
}
