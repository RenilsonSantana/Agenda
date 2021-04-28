//
//  Localizacao.swift
//  Agenda
//
//  Created by Renilson Santana on 20/04/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import MapKit

class Localizacao: NSObject, MKMapViewDelegate {
    
    // MARK: - Metodos
    
    func localizaAlunoNoWaze(_ alunoSelecionado: Aluno){
        //Verificando se tem Waze instalado no iPhone
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!){
            guard let enderecoDoAluno = alunoSelecionado.endereco else { return }
            Localizacao().converteEnderecoEmCoordenadas(endereco: enderecoDoAluno, local: { (localicacaoEncontrada) in
                let latitude = String(describing: localicacaoEncontrada.location!.coordinate.latitude)
                let longitude = String(describing: localicacaoEncontrada.location!.coordinate.longitude)
                let url: String = "waze://?ll\(latitude),\(longitude)&navigate=yes"
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            })
        }
    }
    
    func converteEnderecoEmCoordenadas(endereco: String, local:@escaping(_ local:CLPlacemark) -> Void) {
        let conversor = CLGeocoder()
        conversor.geocodeAddressString(endereco) { (listaDeLocalizacoes, error) in
            if let localizacao = listaDeLocalizacoes?.first{
                local(localizacao)
            }
        }
    }
    
    func configuraPino(titulo: String, localizacao: CLPlacemark, cor: UIColor?, icone: UIImage?) -> Pino {
        let pino = Pino(coordenada: localizacao.location!.coordinate)
        pino.title = titulo
        pino.color = cor
        pino.icon = icone
        return pino
    }
    
    func configuraBotaoLocalizacaoAtual(mapa: MKMapView) -> MKUserTrackingButton{
        let botao = MKUserTrackingButton(mapView: mapa)
        botao.frame.origin.x = 10
        botao.frame.origin.y = 10
        return botao
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is Pino {
            let annotationView = annotation as! Pino
            var pinoView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationView.title!) as? MKMarkerAnnotationView
            pinoView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotation.title!)
            
            pinoView?.annotation = annotationView
            pinoView?.glyphImage = annotationView.icon
            pinoView?.markerTintColor = annotationView.color
            
            return pinoView
        }
        return nil
    }
}
