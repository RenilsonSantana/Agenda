//
//  AlunoAPI.swift
//  Agenda
//
//  Created by Renilson Santana on 27/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import Alamofire

class AlunoAPI: NSObject {
    
    // MARK: - GET
    
    func recuperaAlunosDoServidor(completion: @escaping() -> Void){
        AF.request("http://localhost:8080/api/aluno", method: .get).responseJSON { (response) in
            switch response.result{
            case .success:
                if let resposta = response.value as? Dictionary<String, Any> {
                    self.serializaAlunos(resposta)
                }
                completion()
                break
            case .failure:
                print(response.error!)
                completion()
                break
            }
        }
    }
    
    func recuperaUltimosAlunos(_ versao: String, completion:@escaping() -> Void){
        AF.request("http://localhost:8080/api/aluno/diff", method: .get, headers: ["datahora":versao]).responseJSON { (response) in
            switch response.result {
            case .success:
                if let resposta = response.value as? Dictionary<String, Any>{
                    self.serializaAlunos(resposta)
                }
                completion()
                break
            case .failure:
                break
            }
        }
    }
    
    // MARK: - PUT
    
    func salvaAlunosNoServidor(parametros: Array<Dictionary<String, Any>>, completion:@escaping(_ salvo:Bool) -> Void){
        guard let url = URL(string: "http://localhost:8080/api/aluno/lista") else { return }
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "PUT"
        let json = try! JSONSerialization.data(withJSONObject: parametros, options: [])
        requisicao.httpBody = json
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        AF.request(requisicao).responseJSON { (response) in
            if response.error == nil{
                completion(true)
            }
        }
    }
    
    // MARK: DELETE
    
    func deletaAlunoDoServidor(id: String, completion:@escaping(_ apagado:Bool) -> Void){
        AF.request("http://localhost:8080/api/aluno/\(id)", method: .delete).responseJSON { (response) in
            switch response.result{
            case .success:
                completion(true)
                break
            case .failure:
                completion(false)
                print(response.error!)
                break
            }
        }
    }
    
    // MARK: Serializacão
    
    func serializaAlunos(_ resposta: Dictionary<String, Any>){
        guard let listaDeAlunos = resposta["alunos"] as? Array<Dictionary<String, Any>> else { return }
        for dicionarioDeAlunos in listaDeAlunos{
            guard let status = dicionarioDeAlunos["desativado"] as? Bool else {return}
            if status{
                guard let idDoAluno = dicionarioDeAlunos["id"] as? String else {return}
                guard let UUIDAluno = UUID(uuidString: idDoAluno) else {return}
                if let aluno = AlunoDAO().recuperaAlunos().filter({ $0.id == UUIDAluno }).first {
                    AlunoDAO().deletaAluno(aluno: aluno)
                }
            }
            else{
                AlunoDAO().salvaAluno(dicionarioDeAluno: dicionarioDeAlunos)
            }
        }
        AlunoUserDefaults().salvaVersao(resposta)
    }
}
