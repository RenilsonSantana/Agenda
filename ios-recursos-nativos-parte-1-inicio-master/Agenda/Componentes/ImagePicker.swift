//
//  ImagePicker.swift
//  Agenda
//
//  Created by Renilson Santana on 19/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

protocol ImagemPickerFotoSelecionada{
    func imagePickerFotoSelecionada(_ foto: UIImage)
}

enum MenuOpcoes{
    case camera
    case biblioteca
}

import UIKit

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Atributos
    var delegate:ImagemPickerFotoSelecionada?
    
    // MARK: - Metodos
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let foto = info[UIImagePickerControllerOriginalImage] as! UIImage
        delegate?.imagePickerFotoSelecionada(foto)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func menuDeOpcoes(completion: @escaping(_ opcao: MenuOpcoes) -> Void) -> UIAlertController {
        let menu = UIAlertController(title: "Atencão", message: "Escolha uma das opcões abaixo", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Tirar foto", style: .default) { (acao) in
            completion(.camera)
        }
        menu.addAction(camera)
        
        let biblioteca = UIAlertAction(title: "Biblioteca", style: .default) { (acao) in
            completion(.biblioteca)
        }
        menu.addAction(biblioteca)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        return menu
    }
}
