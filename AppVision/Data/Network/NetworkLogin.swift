//
//  NetworkLogin.swift
//  AppVision
//
//  Created by Cristian Contreras Velásquez on 11-06-24.
//

import Foundation


public protocol NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> Bool
}



public final class NetworkLogin: NetworkLoginProtocol{
    
    public init(){}  //inicializador necesario para usar en las Apps sino no se puede usar
    
    public  func loginApp(user: String, password: String) async -> Bool {
        var tokenJWT:String = ""

        let urlCad : String = "\(ConstantsLibrary.CONST_API_URL)\(EndPoints.login.rawValue)"
        let encodeCredencials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        var segCredential : String = ""
        if let credentials = encodeCredencials{
            segCredential = "Basic \(credentials)"
        }
        
        // creamos el request
        var request : URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type") //Header aplication JSON
        request.addValue(segCredential, forHTTPHeaderField: "Authorization") //Header Basic Authentication
        
        //Call to server
        
        do{
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response  as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    tokenJWT = String(decoding: data, as: UTF8.self) //Asign the Response (Token JWT)
                    
                    //lo grabamos
                    let saveStatus = KeyChainKC().saveKC(key: ConstantsLibrary.CONST_TOKEN_ID_KEYCHAIN, value: tokenJWT)
                    NSLog("Guardado token login \(saveStatus)")
                    
                }
            }
            
        }catch{
            tokenJWT = ""
        }
        
        //lo grabamos
        KeyChainKC().saveKC(key: ConstantsLibrary.CONST_TOKEN_ID_KEYCHAIN, value: tokenJWT)
        return tokenJWT == "" ? false : true

    }
}


public final class NetworkLoginFake: NetworkLoginProtocol{
    public init(){} //inicializador necesario para usar en las Apps sino no se puede usar
    
    public func loginApp(user: String, password: String) async -> Bool {
        let token = UUID().uuidString
        KeyChainKC().saveKC(key: ConstantsLibrary.CONST_TOKEN_ID_KEYCHAIN, value: token)
        return true
    }
}
