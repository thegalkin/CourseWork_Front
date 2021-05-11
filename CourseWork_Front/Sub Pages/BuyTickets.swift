//
//  ByTickets.swift
//  CourseWork_Front
//
//  Created by Никита Галкин on 04.05.2021.
//

import SwiftUI

struct BuyTickets: View {
	var coloumnsAmount: Int = 4
	var coloumns: [GridItem] {
		return
			[GridItem](repeating:
						GridItem(.fixed(70), spacing: 0),
					   count: coloumnsAmount)
	}
	var body: some View {
		ScrollView{
			LazyVGrid(columns: coloumns, alignment: .center, spacing: 15, content: {
				ForEach(1..<100){i in
					Rectangle().frame(width: 40, height: 40)
						.cornerRadius(10)
						.overlay(Text(String(i)).foregroundColor(.yellow))
				}
			})
		}
	}
}

struct BuyTickets_Previews: PreviewProvider {
	static var previews: some View {
		BuyTickets()
	}
}
