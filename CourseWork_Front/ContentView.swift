//
//  ContentView.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 03.05.2021.
//

import SwiftUI

//настройки приложения
class AppSettings: ObservableObject{
	@Published var rootURL: String = getSetting(key: "rootURL")
	@Published var tocken: String = getSetting(key: "userTocken")
	@Published var isShowingSettings = false
}

struct ContentView: View {
	@StateObject var settings: AppSettings = AppSettings()
    var body: some View {
		if settings.rootURL != "" && settings.rootURL != "" && settings.isShowingSettings{
			SettingsView().environmentObject(settings)
		}else{
			TabView(){
				FlightsList().tabItem {
					VStack{
						Image(systemName: "tablecells")
						Text("Вылеты")
					}
				}
				AnyTab(generatorClass: Baggage()).tabItem {
					VStack{
						Image(systemName: "bag")
						Text("Багаж")
					}
				}
				AnyTab(generatorClass: Planes()).tabItem {
					VStack{
						Image(systemName: "airplane.circle")
						Text("Самолеты")
					}
				}
				AnyTab(generatorClass: Employee()).tabItem {
					VStack{
						Image(systemName: "rectangle.stack.person.crop")
						Text("Персонал")
					}
				}
				SettingsView().tabItem {
					VStack{
						Image(systemName: "gear")
						Text("Настройки")
					}
				}
		}.environmentObject(settings)
		}
    }
}

struct SettingsView: View{
	@State var urlSetting: String = getSetting(key: "rootURL")
	@State var userTocken: String = getSetting(key: "userTocken")
	@State var airportCode: String = getSetting(key: "airportCode")
	@EnvironmentObject var settings: AppSettings
	var body: some View{
		VStack(alignment: .center, spacing: 30){
			Text("Настройка").font(.title)
			Spacer()
			TextField("URL", text: $urlSetting)
			TextField("Токен", text: $userTocken)
			TextField("Город", text: $airportCode)
			Text("изначально забыл в системе сделать ориентацию на код аэропорта")
				.foregroundColor(Color(UIColor.quaternaryLabel))
			
			Button(action: {
				setSetting(setting: urlSetting, key: "rootURL")
				setSetting(setting: userTocken, key: "userTocken")
				setSetting(setting: airportCode, key: "airportCode")
				settings.isShowingSettings = false
			}){
				RoundedRectangle(cornerRadius: 4)
					.foregroundColor(.blue)
					
					.overlay(Text("Сохранить...").foregroundColor(Color(UIColor.label)))
					.frame(width: 150, height: 60)
			}
			
			.disabled(!settingsOK(urlSetting, userTocken))
			Spacer()
			
			
		}.frame(maxWidth: 300)
		.navigationTitle("Первичная настройка")
	}
	func settingsOK(_ url: String, _ tocken: String) -> Bool{
		if url != "" && tocken != "" && airportCode != ""{
			return true
		}else{
			return false
		}
	}
}
struct SettingsView_Previews: PreviewProvider {
	static var previews: some View{
		SettingsView()
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

public func setSetting(setting: String, key: String){
	UserDefaults.standard.setValue(setting, forKey: key)
}

public func getSetting(key: String) -> String{
	return UserDefaults.standard.string(forKey: key) ?? ""
}
