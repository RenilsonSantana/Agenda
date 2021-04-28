//
//  Filtro.swift
//  Agenda
//
//  Created by Renilson Santana on 28/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

class Filtro: NSObject {
    func filtrarAlunos(texto: String) -> Array<Aluno>{
        let alunosEncontrados = AlunoDAO().recuperaAlunos().filter{ (aluno) -> Bool in
            if let nome = aluno.nome{
                return nome.contains(texto)
            }
            return false
        }
        return alunosEncontrados
    }
}
