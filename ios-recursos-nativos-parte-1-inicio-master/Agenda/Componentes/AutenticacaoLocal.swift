//
//  AltenticacaoLocal.swift
//  Agenda
//
//  Created by Renilson Santana on 23/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import LocalAuthentication

class AutenticacaoLocal: NSObject {
    
    var error:NSError?

    func autorizacaoUsuario(completion:@escaping(_ autenticado:Bool) -> Void){
        let contexto = LAContext()
        if contexto.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            contexto.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "é necessário autenticacão para deletar um aluno", reply: { (resposta, erro) in
                completion(resposta)
            })
        }
    }
    
}
