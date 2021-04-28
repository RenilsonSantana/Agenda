//
//  AlunoDAO.swift
//  Agenda
//
//  Created by Renilson Santana on 27/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import CoreData

class AlunoDAO: NSObject {
    
    // MARK: - Atributos
    
    var gerenciadorDeResultados: NSFetchedResultsController<Aluno>?
    
    var context:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Metodos
    
    func recuperaAlunos() -> Array<Aluno>{
        
        let pesquisaAluno: NSFetchRequest<Aluno> = Aluno.fetchRequest()
        let ordenaPorNome = NSSortDescriptor(key: "nome", ascending: true)
        pesquisaAluno.sortDescriptors = [ordenaPorNome]
        
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: pesquisaAluno, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            try gerenciadorDeResultados?.performFetch()
        } catch{
            print(error.localizedDescription)
        }
        
        guard let listaDeAlunos = gerenciadorDeResultados?.fetchedObjects else { return [] }
        return listaDeAlunos
    }

    func salvaAluno(dicionarioDeAluno: Dictionary<String, Any>){
        
        var aluno: NSManagedObject?
        guard let id = UUID(uuidString: dicionarioDeAluno["id"] as! String) else { return }
        
        let alunos = recuperaAlunos().filter() { $0.id == id }
        
        if alunos.count > 0 {
            guard let alunoEncontrado = alunos.first else { return }
            aluno = alunoEncontrado
        }
        else {
            let entidade = NSEntityDescription.entity(forEntityName: "Aluno", in: context)
            aluno = NSManagedObject(entity: entidade!, insertInto: context)
        }
        
        aluno?.setValue(id, forKey: "id")
        aluno?.setValue(dicionarioDeAluno["nome"] as? String, forKey: "nome")
        aluno?.setValue(dicionarioDeAluno["endereco"] as? String, forKey: "endereco")
        aluno?.setValue(dicionarioDeAluno["telefone"] as? String, forKey: "telefone")
        aluno?.setValue(dicionarioDeAluno["site"] as? String, forKey: "site")
        aluno?.setValue(("\(String(describing: dicionarioDeAluno["nota"]))" as NSString).doubleValue, forKey: "nota")
        
        atualizaContexto()
    }
    
    func deletaAluno(aluno: Aluno){
        context.delete(aluno)
    }
    
    func atualizaContexto(){
        do{
            try context.save()
        } catch{
            print(error.localizedDescription)
        }
    }
    
}
