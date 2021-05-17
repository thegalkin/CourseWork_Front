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
	var classNameCleaner: String = ""
	
	func cleanClassName(_ className: Any){
		if generatorClass != nil{
			let raw: String = String(describing: generatorClass.self!)
			guard let idx = raw.firstIndex(of: "(") else{
				self.classNameCleaner = raw
				return
			}
			//не использовать - вешает приложение
			//			self.objectWillChange.send()
			self.classNameCleaner = String(raw.prefix(upTo: idx))
		}else{
		//		self.objectWillChange.send()
			self.classNameCleaner =  ""
		}
	}
	
	func getData(){
		if generatorClass != nil{
			if classNameCleaner == "Plane"{
				classNameCleaner = "Planes"
			}
			print("adressing: " + getSetting(key: "rootURL") + "/listAll" + classNameCleaner)
			if classNameCleaner == "Employee"{
				classNameCleaner = "Employees"
			}
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
	var generatorClass: Any
	@State var isAddingNew: Bool = false
	@StateObject var model: Common_ViewModel = Common_ViewModel(generatorClass: nil)
//	init(generatorClass: Any){
//		self.generatorClass = generatorClass
//
//
//	}
	var whoIsAbscent: String{
		switch model.classNameCleaner {
			case "Flight":
				return "Рейсов"
			case "Employee":
				return "Работников"
			case "Planes":
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
							switch model.classNameCleaner {
								case "Flight":
									FlightView(flight: model.data[i])
								case "Employees":
									EmployeeView(db: model.data[i])
								case "Plane":
									PlaneView(db: model.data[i])
								case "Baggage":
									BaggageView(db: model.data[i])
								case "":
									PlaceholerView()
								default:
									PlaceholerView()
							}
							
						}
						
					}
				}else{
					Group{
						Text("\(whoIsAbscent) нет")
					}
				}
				
			}
			.onAppear{
				DispatchQueue.init(label: "sync").sync {
					model.cleanClassName(generatorClass)
					if model.generatorClass == nil{
						model.generatorClass = generatorClass
					}
					model.getData()
				}
				
			}
			.sheet(isPresented: $isAddingNew, content: {AddView(generatorClass: generatorClass)})
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

struct PlaceholerView: View{
	var body: some View{
		Text("заглушка")
	}
}
struct EmployeesView_Previews: PreviewProvider {
	static var previews: some View {
		AnyTab(generatorClass: Employee())
	}
}
