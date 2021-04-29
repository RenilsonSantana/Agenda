//
//  LigacaoTelefone.swift
//  Agenda
//
//  Created by Renilson Santana on 28/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

class LigacaoTelefone: NSObject {
    
    // MARK: - Atributos
    
    func fazLigacao(_ alunoSelecionado: Aluno){
        guard  let numeroDoAluno = alunoSelecionado.telefone else { return }
        if let url = URL(string: "tel://\(numeroDoAluno)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
