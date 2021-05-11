//
//  Flights.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 10.05.2021.
//

import SwiftUI
import SwiftyJSON
import Alamofire

struct Flight: Identifiable, Codable{
	var id: Int64
	private var flightName: String
	private var planeId: String
	private var prevFlightName: String //коннекшн с предыдущим полетом
	private var startTime: TimeInterval
	private var endTime: TimeInterval
	private var planeModel: String
	private var startCountry: String
	private var endCountry: String
	private var startCity: String
	private var endCity: String
	private var passengersAmount: Int
	private var seatsNumbers: [Int]
	private var seatsFullNames: [String]
	private var personnelIds: [Int64]
	private var baggageIds: [Int64]
}

class FlightsList_ViewModel: ObservableObject{
	@Published var flightsData: JSON = JSON()
	
	
	
	func getData(){
		AF.request(getSetting(key: "rootURL") + "/listAll").response{ response in
			switch response.result{
				case .success:
					do{
						try self.flightsData = JSON(data: response.data!)
					}catch{
						print(error.localizedDescription)
					}
				case let .failure(error):
					print(error)
			}
		}
	}
	func createFlight(flight: Flight){
		
	}
}




struct FlightsList: View {
	@StateObject var model = FlightsList_ViewModel()
	
    var body: some View {
		NavigationView{
			Text("Flights")
		
		
		
		
		
		
		
		
		}.toolbar{
			ToolbarItem{
				Button(action:{
					//add
				}){
					Image(systemName: "plus.diamond")
				}
			}
		}
    }
}
struct FlightView: View{
	var flight: JSON
	var home: Bool = false
	var ticketPrice: Int = 0
	init(flight: JSON){
		self.flight = flight
		if flight["startCity"].stringValue == getSetting(key: "airportCode"){
			self.home = true
		}else{
			self.home = false
		}
		self.ticketPrice = Int(unixToDate(flight["endTime"]) - unixToDate(flight["startTime"])) * 1000 // формула вычисления стоимости билета
		//берем часы полета и умножаем на тясячу рублей
	}
	var body: some View{
		VStack{
			
			//1 слой
			
			Text(home ? "Вылет" : "Прилет").font(.headline)
			
			//2 слой
			HStack{
				Text(flight["startCity"].string ?? "Город вылета")
				Text(flight["endCity"].string ?? "Город прилета")
				
				
				Spacer()
				
				
				Text(flight["startTime"].string ?? "Время вылета")
					.foregroundColor(home ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
				Text(flight["endTime"].string ?? "Время прилоета")
					.foregroundColor(!home ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
				
				
				Spacer()
				
				
				Text(flight["flightName"].string ?? "Номер Рейса")
			
			}
		}.background(Color(UIColor.systemGroupedBackground))
	}
}

struct FlightsList_Previews: PreviewProvider {
    static var previews: some View {
        FlightsList()
    }
}

func unixToDate(_ unix: JSON) -> Date{
	return  Date(timeIntervalSince1970: unix.doubleValue)
}

extension Date {
	
	static func - (lhs: Date, rhs: Date) -> TimeInterval {
		return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
	}
	
}
