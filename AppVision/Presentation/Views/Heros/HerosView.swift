//
//  HerosView.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 10-06-24.
//

import SwiftUI
import Kingfisher
//import KCNetworkVisionPro

struct HerosView: View {
    
   
    @StateObject var viewModel: HerosViewModelx
    
    @State private var selectedHero: HeroeResult?
    
    @State private var selectedSeries: [SerieResult]?
    
    @State private var searchText = ""
    
    @State private var letter = "a"
    
    var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    var body: some View {


        NavigationSplitView {

            Text("Letter: \(letter)")
            Picker("", selection: $letter) {
                ForEach(alphabet, id: \.self) {
                    Text("\($0)")
                }
            }
            .onChange(of: letter) { oldValue, newValue in
                Task {
                    await   self.viewModel.getHeros(firstLetter: letter)
                }
            }

            List(selection: $selectedHero){
                
                ForEach(viewModel.heros){data in
                    if data.thumbnail.Image() != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"{
                        NavigationLink(value: data) {
                            HerosRowView(hero: data)
                        }.tag(data)
                    }
                    
                }
                .padding(.vertical)
            } 
            .navigationTitle("Heroes")
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Buscar heroe por nombre")
        
        }  content: {
            VStack{
                if let hero = selectedHero {
                    
                    NavigationStack{
                        VStack{
                            KFImage.url(URL(string: hero.thumbnail.Image())!)
                            Text(hero.resultDescription)
                            
                        }
                    }
                    .navigationTitle(hero.name)
                    .onChange(of: hero){
                        Task {
                            
                            await   viewModel.getSeries(HeroID:String( selectedHero?.id ?? 0))
                        }
                    }
                } else {
                    ContentUnavailableView("selecciona un Superheroe",
                     systemImage: "person.fill")
                }
            }
        } detail: {
            NavigationStack{
                
                if let hero = selectedHero {
                    List {
                        ForEach(viewModel.series) {
                            trans in
                           VStack{
                               KFImage.url(URL(string: trans.thumbnail.Image())!)
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
                      
//                                
                               Text(trans.title)
                                    .font(.title2)
                               
                               Text(trans.description ?? "")
                                    .font(.caption2)
                                
                            }
                      }
                    }
                } else {
                    ContentUnavailableView("Sin Datos", systemImage: "cube.transparent")
                }
                
            }
            .navigationTitle("Series")
        }
        .onAppear{
            //self.viewModel.getHeros(filter: "")
            Task {
             await   self.viewModel.getHeros(firstLetter: letter)
                
            }
        }
        .ornament(attachmentAnchor: .scene(.bottom)) {
            //contenido del Ornament
            HStack {
                Button(action: {
                    if let hero = selectedHero {
                       // appStateVM.setHero(hero: hero)
                        
                        //Todo: llamar a la ventana de localizaciones
                    }
                    
                }, label: {
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 45, height: 45)
                })
                
                Button(action: {
                    
                    
                }, label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 45, height: 45)
                })

            }
            .frame(width: 400, height: 80)
            .glassBackgroundEffect(in: .rect(cornerRadius: 40))
        }
        .onChange(of: searchText) {
            Task {
   //             await viewModel.getHeros(filter: searchText)
            }
        }

    }
}

//#Preview {
//    HerosView(viewModel: HerosViewModel(useCaseHeros: UseCaseHerosFake()))
//        .environment(AppStateVM())
//}

