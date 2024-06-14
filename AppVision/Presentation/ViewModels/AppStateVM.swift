//
//  AppStateVM.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 09-06-24.
//

import Foundation
//import KCNetworkVisionPro


// : observableObject
@Observable
final class AppStateVM {
    var status = Status.none
    
    @ObservationIgnored
    var isLogged = false
    
    @ObservationIgnored
    var heroSelected: HerosData?
    
    init(){
        Task {
            await controlLogin()
        }
    }
    
    func login(user: String, password: String) async {
        let loginOK = await UseCaseLogin().loginApp(user: user, password: password)
        
        DispatchQueue.main.async {
            if loginOK {
                self.status = .loaded
                self.isLogged = true
            } else {
                self.status = .error(error: "Ususario/clave no son correctodos")
                self.isLogged = false
            }
        }
    }
    
    func closeSession(){
        _ = UseCaseLogin().closeSession()
        isLogged = false
        status = .none
    }
    
    func controlLogin() async {
        if await UseCaseLogin().isLogged() {
            
            DispatchQueue.main.async {
                self.status = .loaded
                self.isLogged = true
            }
        }
    }
    
    func setHero(hero: HerosData) {
        self.heroSelected = hero
    }
}

