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
    
    // MARK: Atributo
    
    var delegate: MFMessageComposeViewControllerDelegate?
    
    // MARK: - Metodos
    
    func setaDelegate() -> MFMessageComposeViewControllerDelegate?{
        delegate = self
        
        return delegate
    }
    
    func enviaSMS(_ aluno:Aluno, controller:UIViewController) {
        if MFMessageComposeViewController.canSendText() {
            let componenteMensagem = MFMessageComposeViewController()
            
            guard let numeroDoAluno = aluno.telefone else {return }
            
            componenteMensagem.recipients = [numeroDoAluno]
            guard let delegate = setaDelegate() else { return }
            componenteMensagem.messageComposeDelegate = delegate
            
            controller.present(componenteMensagem, animated: true, completion: nil)
        }
    }
    
    // MARK: - MFMessageComposeViewControllerDelegate
    //Metodo disparado quando o botão cancelar for precionado
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
