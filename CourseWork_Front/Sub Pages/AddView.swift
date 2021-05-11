//
//  AddView.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 11.05.2021.
//

import SwiftUI
import Combine
import Alamofire
import SwiftyJSON

/*
Это универсальный класс, который будет адаптироваться под структуру создавая необходимые поля формы на основе
полученной структуры(класса)

*/


struct AddView<T>: View where T: ObservableObject{
	var generatorClass: T
	var mirror: Mirror? = nil
	init(generatorClass: T){
		self.generatorClass = generatorClass
		
		self.mirror = Mirror(reflecting: generatorClass)
		assert(self.mirror != nil, "Mirror refrection is nil")
	}
	
	@State var fieldsData: [String: String] = [:]
	@State var anyField: String = "" //нужно, потому что по биндингу к словарю подключаться нельзя
	
	@Environment(\.presentationMode) var presentationMode
	
	@State var isShowingSuccessAlert: Bool = false
	@State var isShowingFailureAlert: Bool = false
	
	var body: some View {
		if mirror != nil{
			LazyVStack{
				Text("Создание \(String(describing: generatorClass.self))").font(.largeTitle)
				
				Spacer()
				
				ForEach(0..<mirror!.children.count){ i in
					let ch = mirror?.children[ //ссылаемся на конкретный индекс
						(mirror?.children.index(
							//получаем индекс из компактного(хаха) итератора
							(mirror?.children.startIndex)!,
							offsetBy: i)
						)!]
					let label: String = (ch?.label!.chopPrefix(1))!
					//					let value: String = (ch?.value!.chopPrefix(1))!
					TextField(label, text: $anyField)
						.onReceive(Just(label)){ new in
							fieldsData[label] = new
						}
					
					Button(action: {
						addNew()
					}){
						RoundedRectangle(cornerRadius: 4)
							.foregroundColor(.blue)
							
							.overlay(Text("Сохранить...").foregroundColor(Color(UIColor.label)))
							.frame(width: 150, height: 60)
					}
					
					.disabled(!settingsOK(dict: fieldsData, targetSize: mirror!.children.count))
					Spacer()
				}
			}.alert(isPresented: $isShowingSuccessAlert){
				Alert(title: Text("Успех"), dismissButton: .default(Text("OK"), action: {presentationMode.wrappedValue.dismiss()}))
					
			}.alert(isPresented: $isShowingFailureAlert){
				Alert(title: Text("Неудача"), dismissButton: .cancel(Text("OK")))
			}
		}
	}
	func settingsOK(dict: [String: String], targetSize: Int) -> Bool{
		if dict.count == targetSize {
			return true
		}else{
			return false
		}
	}
	func addNew(){
		let object = String(describing: generatorClass.self)
		AF.request(getSetting(key: "rootURL") + "/\(object)", method: .post, parameters: fieldsData).response{ response in
			switch response.result{
				case .success:
					print("success")
					isShowingSuccessAlert = true
				case let .failure(error):
					isShowingFailureAlert = true
					print(error)
			}
		}
	}
}

struct AddView_Previews: PreviewProvider {
	class testClass: ObservableObject{
		@Published var first: String = "1"
		@Published var second: String = "2"
		@Published var third: String = "3"
	}
	
	@ObservedObject static var cls = testClass()
	static var previews: some View {
		AddView(generatorClass: cls)
	}
}


extension String {
	func chopPrefix(_ count: Int = 1) -> String {
		return substring(from: index(startIndex, offsetBy: count))
	}
	
	func chopSuffix(_ count: Int = 1) -> String {
		return substring(to: index(endIndex, offsetBy: -count))
	}
}
