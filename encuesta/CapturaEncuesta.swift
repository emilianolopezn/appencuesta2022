//
//  CapturaEncuesta.swift
//  encuesta
//
//  Created by MaestroD1 on 5/13/22.
//  Copyright © 2022 MaestroD1. All rights reserved.
//

import Foundation

struct CapturaEncuesta : Codable {
    var id_tipo_usuario : Int
    var matricula : String?
    var numero_profesor : String?
    var numero_empleado : String?
    var nombre : String
    var correo : String
    var contacto_covid : Bool
    var vacunado : Bool
}
