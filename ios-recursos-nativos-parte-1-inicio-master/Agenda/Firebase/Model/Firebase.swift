//
//  Firebase.swift
//  Agenda
//
//  Created by Renilson Santana on 28/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import Alamofire

class Firebase: NSObject {
    
    func enviarTokenParaServidor(token: String){
        AF.request("htpp://localhost:8080/api/firebase/dispositivo", method: .post, headers: ["token":token]).responseData{ (resposta) in
            if resposta.error == nil {
                print("TOKEN ENVIADO COM SUCESSO!")
            }
            else{
                print("ERROR---------------")
                print(resposta.error!)
            }
        }
    }
    
}
