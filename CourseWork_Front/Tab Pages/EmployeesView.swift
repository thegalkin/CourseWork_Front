//
//  EmployeesView.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 04.05.2021.
//

import SwiftUI

struct EmployeesView: View {
	@State var isAddingNew: Bool = false
	var body: some View {
		NavigationView{
			Text("Employees")
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
		EmployeesView()
	}
}
