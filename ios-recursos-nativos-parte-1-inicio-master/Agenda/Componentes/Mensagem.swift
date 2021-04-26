//
//  Mensagem.swift
//  Agenda
//
//  Created by Renilson Santana on 20/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import MessageUI

class Mensagem: NSObject, MFMessageComposeViewControllerDelegate {
    
    // MARK: - Metodos
    
    func configuraSMS(_ aluno:Aluno) -> MFMessageComposeViewController? {
        if MFMessageComposeViewController.canSendText() {
            let componenteMensagem = MFMessageComposeViewController()
            
            guard let numeroDoAluno = aluno.telefone else {return componenteMensagem}
            
            componenteMensagem.recipients = [numeroDoAluno]
            componenteMensagem.messageComposeDelegate = self
        }
        return nil
    }
    
    // MARK: - MFMessageComposeViewControllerDelegate
    //Metodo disparado quando o botão cancelar for precionado
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
