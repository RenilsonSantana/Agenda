//
//  Notificacoes.swift
//  Agenda
//
//  Created by Renilson Santana on 22/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

class Notificacoes: NSObject {
    func exibeNotificacaoDeMediaDosAlunos(dicionarioDeMedia:Dictionary<String, Any>) -> UIAlertController?{
        if let media = dicionarioDeMedia["media"] as? String {
            let alerta = UIAlertController(title: "Atencão", message: "A media geral dos alucos é: \(media)", preferredStyle: .alert)
            let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(botao)
            
            return alerta
        }
        return nil
    }
}
