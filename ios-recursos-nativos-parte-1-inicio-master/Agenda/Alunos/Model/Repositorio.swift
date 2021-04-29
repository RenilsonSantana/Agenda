//
//  Repositorio.swift
//  Agenda
//
//  Created by Renilson Santana on 27/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

class Repositorio: NSObject {
    
    // MARK: - Metodos
    
    //Não entendi absolutamente nada
    func recuperaAlunos(completion: @escaping(_ listaDeAlunos: Array<Aluno>) -> Void){
        var alunos = AlunoDAO().recuperaAlunos().filter({ $0.desativado == false })
        if alunos.count == 0 {
            AlunoAPI().recuperaAlunosDoServidor{
                alunos = AlunoDAO().recuperaAlunos()
                completion(alunos)
            }
        }
        else {
            completion(alunos)
        }
    }
    
    func recuperaUltimosAlunos(_ versao:String, completion:@escaping() -> Void){
        AlunoAPI().recuperaUltimosAlunos(versao){
            completion()
        }
    }

    func salvaAluno(aluno: Dictionary<String, Any>){
        AlunoDAO().salvaAluno(dicionarioDeAluno: aluno)
        AlunoAPI().salvaAlunosNoServidor(parametros: [aluno]) { (salvo) in
            if salvo{
                self.atualizaAlunoSincronizado(aluno)
            }
        }
    }
    
    func deletaAluno(aluno:Aluno){
        aluno.desativado = true
        AlunoDAO().atualizaContexto()
        guard let id = aluno.id else { return }
        AlunoAPI().deletaAlunoDoServidor(id: String(describing: id).lowercased()) { (apagado) in
            if apagado{
                AlunoDAO().deletaAluno(aluno: aluno)
            }
        }
        
    }
    
    func sincronizaAlunos(){
        enviaAlunosNaoSincrinizados()
        sincronizaAlunosDeletados()
    }
    
    func sincronizaAlunosDeletados(){
        let alunos = AlunoDAO().recuperaAlunos().filter({ $0.desativado == true})
        for aluno in alunos{
            deletaAluno(aluno: aluno)
        }
    }
    
    func enviaAlunosNaoSincrinizados(){
        let alunos = AlunoDAO().recuperaAlunos().filter({ $0.sincronizado == false })
        let listaDeParametros = criaJsonAlunos(alunos)
        AlunoAPI().salvaAlunosNoServidor(parametros: listaDeParametros) { (salvo) in
            for aluno in listaDeParametros{
                self.atualizaAlunoSincronizado(aluno)
            }
        }
    }
    
    func criaJsonAlunos(_ alunos: Array<Aluno>) -> Array<[String:Any]>{
        var listaDeParametros:Array<Dictionary<String, String>> = []
        for aluno in alunos{
            guard let id = aluno.id else { return []}
            let parametros:Dictionary<String, String> = [
                "id" : String(describing: id).lowercased(),
                "nome" : aluno.nome ?? "",
                "endereco" : aluno.endereco ?? "",
                "telefone" : aluno.telefone ?? "",
                "site" : aluno.site ?? "",
                "nota" : "\(aluno.nota)",
            ]
            listaDeParametros.append(parametros)
        }
        return listaDeParametros
    }
    
    func atualizaAlunoSincronizado(_ aluno:Dictionary<String, Any>){
        var dicionario = aluno
        dicionario["sincronizado"] = true
        AlunoDAO().salvaAluno(dicionarioDeAluno: dicionario)
    }
}
