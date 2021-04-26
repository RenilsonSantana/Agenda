//
//  MenuOpcoesAlunos.swift
//  Agenda
//
//  Created by Renilson Santana on 20/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

enum MenuActionSheetAluno{
    case sms
    case ligacao
    case waze
    case mapa
    case abrirWebSite
}

class MenuOpcoesAlunos: NSObject {
    
    func configuraMenuDeOpcoesDoAluno(completion:@escaping(_ opcao:MenuActionSheetAluno) -> Void) -> UIAlertController{
        let menu = UIAlertController(title: "Atencão", message: "escolha uma das opcões abaixo", preferredStyle: .actionSheet)
        
        let sms = UIAlertAction(title: "enviar SMS", style: .default) { (acao) in
            completion(.sms)
        }
        menu.addAction(sms)
        
        let ligar = UIAlertAction(title: "ligar", style: .default) { (acao) in
            completion(.ligacao)
        }
        menu.addAction(ligar)
        
        let waze = UIAlertAction(title: "localizar no waze", style: .default) { (acao) in
            completion(.waze)
        }
        menu.addAction(waze)
        
        let mapa = UIAlertAction(title: "abrir mapa", style: .default) { (acao) in
            completion(.mapa)
        }
        menu.addAction(mapa)
        
        let abrirSite = UIAlertAction(title: "abrir web site", style: .default) { (acao) in
            completion(.abrirWebSite)
        }
        menu.addAction(abrirSite)
        
        let cancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        return menu
    }
}
