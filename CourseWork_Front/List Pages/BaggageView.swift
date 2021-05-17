//
//  BaggageVIew.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 15.05.2021.
//

import SwiftUI
import SwiftyJSON

struct BaggageView: View {
	var db: JSON
    var body: some View {
		NavigationLink(destination: BaggageDetailView(db: db)){
			LazyHStack{
				Text(String(db["id"].int64Value))
				Text(db["ownerFullName"].string ?? "Имя")
				Text(db["flightId"].string ?? "Рейс")
				Text(db["startCountry"].string ?? "Страна отправления")
			}
		}
    }
}

struct BaggageDetailView: View{
	var db: JSON
	var body: some View{
		LazyVStack{
			LazyHStack{
				Text(String(db["id"].int64Value))
				Text(db["ownerFullName"].string ?? "Имя")
				Text(db["flightId"].string ?? "Рейс")
				Text(db["startCountry"].string ?? "Страна отправления")
			}
			Text(db["targetFlightName"].string ?? "Следующий рейс")
			if let middleCountries = db["middleCountries"]{
				Text("Промежуточные страны: ")
				ForEach(0..<middleCountries.count){ i in
					Text("  \(middleCountries.arrayValue[i].stringValue)")
				}
			}else{
				Text("Следует напрямую")
			}
			Text(db["endCountry"].string ?? "Куда следует")
			
		}
	}
}
