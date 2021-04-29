//
//  Firebase.swift
//  Agenda
//
//  Created by Renilson Santana on 28/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class Firebase: NSObject {
    
    enum StatusDoAluno: Int {
        case ativo
        case inativo
    }
    
    func enviarTokenParaServidor(token: String){
        AF.request("htpp://localhost:8080/api/firebase/dispositivo", method: .post, headers: ["token":token]).responseData{ (resposta) in
            
        }
    }
    
    func sincronizaAlunos(alunos:Array<[String:Any]>){
        for aluno in alunos {
            guard let status = aluno["desativado"] as? Int else {return}
            if status == StatusDoAluno.ativo.rawValue{
                AlunoDAO().salvaAluno(dicionarioDeAluno: aluno)
            }
            else{
                guard let idDoAluno = aluno["id"] as? String else {return}
                guard let aluno = AlunoDAO().recuperaAlunos().filter({ $0.id == UUID(uuidString: idDoAluno) }).first else {return}
                AlunoDAO().deletaAluno(aluno: aluno)
            }
        }
    }
    
}
