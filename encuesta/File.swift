//
//  File.swift
//  encuesta
//
//  Created by MaestroD1 on 3/11/22.
//  Copyright © 2022 MaestroD1. All rights reserved.
//

import Foundation
import UIKit

class MiController : UIViewController {
    
    var estadoVacunado = false
    
    @IBOutlet weak var imgVacunado: UIImageView!
    @IBOutlet var doTapVacunado: UITapGestureRecognizer!
    @IBAction func doClickVacunado(_ sender: Any) {
        estadoVacunado = !estadoVacunado
        if estadoVacunado {
            imgVacunado.image = UIImage(named: "contagio")
        } else {
            imgVacunado.image = UIImage(named: "contacto")
        }
    }
}
