//
//  Safari.swift
//  Agenda
//
//  Created by Renilson Santana on 28/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import SafariServices

class Safari: NSObject {
    
    
    // MARK: - Metodos
    
    func abrePaginaWeb(_ alunoSelecionado: Aluno, controller: UIViewController){
        if let urlDoAluno = alunoSelecionado.site{
            var urlFormatada = urlDoAluno
            
            if !urlFormatada.hasPrefix("https://"){
                urlFormatada = String(format: "https://%@", urlFormatada)
            }
            
            guard let url = URL(string: urlFormatada) else { return }
            let safariViewController = SFSafariViewController(url: url)
            controller.present(safariViewController, animated: true, completion: nil)
        }
    }
}
