//
//  BaggageView.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 04.05.2021.
//

import SwiftUI

struct BaggageView: View {
	@State var isAddingNew: Bool = false
	var body: some View {
		NavigationView{
			Text("Baggage")
				.sheet(isPresented: $isAddingNew, content: {AddView(generatorClass: Baggage())})
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

struct BaggageView_Previews: PreviewProvider {
	static var previews: some View {
		BaggageView()
	}
}
