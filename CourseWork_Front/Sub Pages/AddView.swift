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


struct AddView: View{
	var generatorClass: Any
	var mirror: Mirror? = nil
	init(generatorClass: Any){
		self.generatorClass = generatorClass
		
		self.mirror = Mirror(reflecting: generatorClass)
		assert(self.mirror != nil, "Mirror refrection is nil")
	}
	
	@State var fieldsData: [String: String] = [:]
	@State var anyField: String = "" //нужно, потому что по биндингу к словарю подключаться нельзя
	
	@Environment(\.presentationMode) var presentationMode
	
	@State var isShowingSuccessAlert: Bool = false
	@State var isShowingFailureAlert: Bool = false
	
	var settingsOK: Bool {
		return !settingsOK(dict: fieldsData, targetSize: mirror!.children.count)
	}
	var classNameCleaner: String {
		let raw: String = String(describing: generatorClass.self)
		guard let idx = raw.firstIndex(of: "(") else{
			return raw
		}
		return String(raw.prefix(upTo: idx))
	}
	
	var body: some View {
		if mirror != nil{
			VStack{
				Text("Создание \(classNameCleaner)").font(.largeTitle)
				
				Spacer()
				
				ForEach(0..<mirror!.children.count){ i in
					let ch = mirror?.children[ //ссылаемся на конкретный индекс
						(mirror?.children.index(
							//получаем индекс из компактного(хаха) итератора
							(mirror?.children.startIndex)!,
							offsetBy: i)
						)!]
					let label: String = (ch?.label!.replacingOccurrences(of: "_", with: ""))!
					//					let value: String = (ch?.value!.chopPrefix(1))!
					
					var fieldBind: Binding<String> = Binding<String>(
						get: {
							if fieldsData[label] != label{
								return fieldsData[label] ?? ""
							}else{
								return ""
							}
						}, set: { newVal in
//							if newVal != label{
								fieldsData[label] = newVal
//							}
						})
					TextField(label, text: fieldBind)

					
					
				}
				Spacer()
				Button(action: {
					addNew()
				}){
					RoundedRectangle(cornerRadius: 4)
						.foregroundColor(!settingsOK ? .blue : .red)
						
						.overlay(Text("Сохранить...").foregroundColor(Color(UIColor.label)))
						.frame(width: 150, height: 60)
				}
				
				.disabled(settingsOK)
				
			}.frame(maxWidth: UIScreen.main.bounds.width / 100 * 90)
			.alert(isPresented: $isShowingSuccessAlert){
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
		AF.request(getSetting(key: "rootURL") + "/\(classNameCleaner)", method: .post, parameters: fieldsData).response{ response in
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
	
	static var previews: some View {
		AddView(generatorClass: Flight())
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
