//
//  HerosRowView.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 10-06-24.
//

import SwiftUI
import Kingfisher
//import KCNetworkVisionPro

struct HerosRowView: View {
    //let hero: HerosData
    var hero: HeroeResult //el modelo
    
    var body: some View {
        ZStack{
            KFImage.url(URL(string: hero.thumbnail.Image())!)
                .placeholder({
                    Image("Marvel_Logo_Red")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding([.leading, .trailing],20)
                        .opacity(0.6)
                })
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding([.leading, .trailing],20)
                .opacity(0.6)
            
            Text("\(hero.name)")
                .font(.title)
                .foregroundStyle(.white)
            

        }
    }
}

#Preview {
    HerosRowView(hero: HeroeResult(id: 1, name: "Hit-Monkey", resultDescription: "", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/30/4ce69c2246c21", thumbnailExtension: "jpg")))
}
