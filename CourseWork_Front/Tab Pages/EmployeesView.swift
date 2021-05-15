//
//  EmployeesView.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 04.05.2021.
//

import SwiftUI
import SwiftyJSON
import Alamofire

class Common_ViewModel: ObservableObject{
	@Published var data: JSON = JSON()
	var generatorClass: Any?
	init(generatorClass: Any?){
		if generatorClass != nil{
			self.generatorClass = generatorClass
		}
	}
	var classNameCleaner: String {
		if generatorClass != nil{
			let raw: String = String(describing: generatorClass.self)
			guard let idx = raw.firstIndex(of: "(") else{
				return raw
			}
			return String(raw.prefix(upTo: idx))
		}
		return ""
	}
	
	func getData(){
		if generatorClass != nil{
			print("rootURL" + getSetting(key: "rootURL"))
			AF.request(getSetting(key: "rootURL") + "/listAll"+classNameCleaner).response{ response in
				switch response.result{
					case .success:
						do{
							try self.data = JSON(data: response.data!)
							print(self.data)
						}catch{
							print(error.localizedDescription)
						}
					case let .failure(error):
						print(error)
				}
			}
		}
	}
}

struct AnyTab: View {
	@State var generatorClass: Any?
	@State var isAddingNew: Bool = false
	@StateObject var model: Common_ViewModel = Common_ViewModel(generatorClass: nil)
	init(generatorClass: Any){
		self.generatorClass = generatorClass
		if model.generatorClass == nil{
			model.generatorClass = generatorClass
		}
	}
	var whoIsAbscent: String{
		switch model.classNameCleaner {
			case "Flight":
				return "Рейсов"
			case "Employee":
				return "Работников"
			case "Plane":
				return "Самолётов"
			case "Baggage":
				return "Багажа"
			case "":
				return "Инициализируемого"
			default:
				return "Чего-то"
		}
	}
	var body: some View {
		NavigationView{
			Group{
				if model.data.count != 0{
					List(){
						ForEach(0..<model.data.count, id: \.self){ i in
							FlightView(flight: model.data[i])
						}
						
					}
				}else{
					Group{
						Text("\(whoIsAbscent) нет")
					}
				}
				
			}
			.onAppear{
				model.getData()
			}
			.sheet(isPresented: $isAddingNew, content: {AddView(generatorClass: Employee())})
			.toolbar{
				ToolbarItem(placement: .navigationBarTrailing){
					Button(action:{
						isAddingNew = true
					}){
						Image(systemName: "plus")
					}
				}
			}
		}
	}
}

struct EmployeesView_Previews: PreviewProvider {
	static var previews: some View {
		AnyTab(generatorClass: Employee())
	}
}
