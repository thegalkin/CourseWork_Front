//
//  PlanesView.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 04.05.2021.
//

import SwiftUI

struct PlanesView: View {
	@State var isAddingNew: Bool = false
    var body: some View {
		NavigationView{
			Text("Planes")
				.sheet(isPresented: $isAddingNew, content: {AddView(generatorClass: Planes())})
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

struct PlanesView_Previews: PreviewProvider {
    static var previews: some View {
        PlanesView()
    }
}
