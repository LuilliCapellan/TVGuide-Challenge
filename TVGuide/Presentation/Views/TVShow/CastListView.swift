//
//  CastListView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/5/25.
//

import SwiftUI

struct CastListView: View {
    let cast: [TVShow.CastMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(cast, id: \.person.id) { member in
                    NavigationLink {
                        PersonDetailView(person: member.person)
                    } label: {
                        VStack {
                            PeopleImageView(imageURL: member.person.image?.medium)
                            
                            Text(member.person.name)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .frame(width: 100)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CastListView(cast: [
        TVShow.CastMember(person: Person(id: 1, name: "Bryan Cranston", country: nil, image: Person.ImageURLs(medium: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg"), original: nil))),
        TVShow.CastMember(person: Person(id: 2, name: "Aaron Paul", country: nil, image: Person.ImageURLs(medium: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/200/501942.jpg"), original: nil))),
        TVShow.CastMember(person: Person(id: 3, name: "Anna Gunn", country: nil, image: nil))
    ])
}
