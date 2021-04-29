//
//  AlunoUserDefaults.swift
//  Agenda
//
//  Created by Renilson Santana on 29/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

class AlunoUserDefaults: NSObject {
    
    let preferencias = UserDefaults.standard

    func salvaVersao(_ json:Dictionary<String, Any>){
        guard let versao = json["momentoDaUltimaModificacao"] as? String else {return}
        preferencias.setValue(versao, forKey: "ultimaVersao")
    }
    
    func recuperaUltimaVersao() -> String? {
        let versao = preferencias.object(forKey: "ultimaVersao") as? String
        return versao
    }
    
}
