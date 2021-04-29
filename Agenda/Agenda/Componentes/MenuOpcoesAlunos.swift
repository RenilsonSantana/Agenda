//
//  MenuOpcoesAlunos.swift
//  Agenda
//
//  Created by Renilson Santana on 20/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

class MenuOpcoesAlunos: NSObject {
    
    func configuraMenuDeOpcoesDoAluno(navigation: UINavigationController, alunoSelecionado: Aluno) -> UIAlertController{
        let menu = UIAlertController(title: "Atencão", message: "escolha uma das opcões abaixo", preferredStyle: .actionSheet)
        
        guard let viewController = navigation.viewControllers.last else { return menu }
        
        let sms = UIAlertAction(title: "enviar SMS", style: .default) { (acao) in
            Mensagem().enviaSMS(alunoSelecionado, controller: viewController)
        }
        menu.addAction(sms)
        
        let ligar = UIAlertAction(title: "ligar", style: .default) { (acao) in
            LigacaoTelefone().fazLigacao(alunoSelecionado)
        }
        menu.addAction(ligar)
        
        let waze = UIAlertAction(title: "localizar no waze", style: .default) { (acao) in
            Localizacao().localizaAlunoNoWaze(alunoSelecionado)
        }
        menu.addAction(waze)
        
        let mapa = UIAlertAction(title: "abrir mapa", style: .default) { (acao) in
            let mapa = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapa") as! MapaViewController
            mapa.aluno = alunoSelecionado
            navigation.pushViewController(mapa, animated: true)
        }
        menu.addAction(mapa)
        
        let abrirSite = UIAlertAction(title: "abrir web site", style: .default) { (acao) in
            Safari().abrePaginaWeb(alunoSelecionado, controller: viewController)
        }
        menu.addAction(abrirSite)
        
        let cancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        return menu
    }
}
