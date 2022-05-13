//
//  ViewController.swift
//  encuesta
//
//  Created by MaestroD1 on 3/7/22.
//  Copyright © 2022 MaestroD1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var swNinguno: UISwitch!
    @IBOutlet weak var swCansancio: UISwitch!
    @IBOutlet weak var swDolor: UISwitch!
    @IBOutlet weak var swTos: UISwitch!
    @IBOutlet weak var swFiebre: UISwitch!
    @IBOutlet weak var swPositivo: UISwitch!
    @IBOutlet weak var vwCover: UIView!
    @IBOutlet weak var vwVacuna: UIView!
    @IBOutlet weak var vwPreguntas: UIView!
    @IBOutlet weak var vwSintomas: UIView!
    @IBOutlet weak var vwInfoGeneral: UIView!
    @IBOutlet weak var lblEtiquetaMatricula: UILabel!
    @IBOutlet weak var txtMatricula: UITextField!
    @IBOutlet weak var lblRetroInfoGeneral: UILabel!
    
    @IBOutlet weak var btnAtras: UIButton!
    @IBOutlet weak var pvProgresoEncuesta: UIProgressView!
    @IBOutlet weak var vwSelectedContagioSi: UIView!
    @IBOutlet weak var vwSelectedContagioNo: UIView!
    @IBOutlet weak var lblSelectedContagioSi: UILabel!
    @IBOutlet weak var lblSelectedContagioNo: UILabel!
    
    @IBOutlet weak var lblRetroVacunado: UILabel!
    
    @IBOutlet weak var btnSiguiente: UIButton!
    @IBOutlet weak var lblSelectedVacunaNo: UILabel!
    @IBOutlet weak var lblSelectedVacunaSi: UILabel!
    @IBOutlet weak var vwSelectedVacunaNo: UIView!
    @IBOutlet weak var vwSelectedVacunaSi: UIView!
    
    @IBOutlet weak var lblRetroContagio: UILabel!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var scTipoUsuario: UISegmentedControl!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    enum OpcionesSiNo {
        case Si
        case No
        case SinContestar
    }
    var contactoCovid = OpcionesSiNo.SinContestar
    var vacunado = OpcionesSiNo.SinContestar
    
    
    enum EstadoEncuesta {
        case InformacionGeneral
        case Preguntas
        case Sintomas
        case Vacunas
    }
    
    var estadoEncuesta = EstadoEncuesta.InformacionGeneral
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwInfoGeneral.alpha = 1.0
        vwVacuna.alpha = 0.0
        vwPreguntas.alpha = 0.0
        vwSintomas.alpha = 0.0
        
        //Inicio info general
        lblRetroInfoGeneral.isHidden = true
        
        
        //Inicio contagio
        vwSelectedContagioNo.isHidden = true
        vwSelectedContagioNo.layer.cornerRadius = 10
        vwSelectedContagioSi.isHidden = true
        vwSelectedContagioSi.layer.cornerRadius = 10
        lblRetroContagio.isHidden = true
        
        //Inicio vacunado
        vwSelectedVacunaSi.isHidden = true
        vwSelectedVacunaSi.layer.cornerRadius = 10
        vwSelectedVacunaNo.isHidden = true
        vwSelectedVacunaNo.layer.cornerRadius = 10
        lblRetroVacunado.isHidden = true
        
        //inicia gradiente
        let gradiente = CAGradientLayer()
        gradiente.frame = vwCover.bounds
        gradiente.colors =
        [UIColor(red: 0, green: 30/255, blue: 98/255, alpha: 1).cgColor, UIColor(red: 200/255, green: 16/255, blue: 46/255, alpha: 1).cgColor]
        gradiente.startPoint = CGPoint(x: 0, y: 0.5)
        gradiente.endPoint = CGPoint(x: 1, y: 0.5)
        gradiente.shouldRasterize = true
        
        vwCover.layer.addSublayer(gradiente)
        //termina gradiente
        vwCover.layer.cornerRadius = 30
    }

    @IBAction func doChangeTipoUsuario(_ sender: Any) {
        if (scTipoUsuario.selectedSegmentIndex == 0) {
            lblEtiquetaMatricula.text = "Matrícula"
            txtMatricula.placeholder = "Ingresa matrícula"
        } else if (scTipoUsuario.selectedSegmentIndex == 1) {
            lblEtiquetaMatricula.text = "Número de profesor"
            txtMatricula.placeholder = "Ingresa número de profesor"
        } else if (scTipoUsuario.selectedSegmentIndex == 2) {
            lblEtiquetaMatricula.text = "Número de empleado"
            txtMatricula.placeholder = "Ingresa número de empleado"
        }
    }
    
    @IBAction func doTapSiguiente(_ sender: Any) {
        switch(estadoEncuesta) {
        case .InformacionGeneral:
            var todoBien = true
            lblRetroInfoGeneral.isHidden = true
            if (txtMatricula.text == nil || txtMatricula.text!.isEmpty) {
                todoBien = false
                lblRetroInfoGeneral.isHidden = false
                lblRetroInfoGeneral.text = "*Es necesario ingresar número de identificación"
            } else if (txtNombre.text == nil || txtNombre.text!.isEmpty) {
                todoBien = false
                lblRetroInfoGeneral.isHidden = false
                lblRetroInfoGeneral.text = "*Es necesario ingresar nombre completo"
            } else if (txtCorreo.text == nil || txtCorreo.text!.isEmpty) {
                todoBien = false
                lblRetroInfoGeneral.isHidden = false
                lblRetroInfoGeneral.text = "*Es necesario ingresar correo electrónico"
            }
            if (todoBien) {
                UIView.animate(withDuration: 0.3, animations: {
                    self.vwInfoGeneral.alpha = 0.0
                    self.vwVacuna.alpha = 0.0
                    self.vwPreguntas.alpha = 1.0
                    self.vwSintomas.alpha = 0.0
                    self.estadoEncuesta = .Preguntas
                    self.pvProgresoEncuesta.progress = 0.25
                }, completion: nil)
                
            }
            
        case .Preguntas:
            
            lblRetroContagio.isHidden = true
            if (contactoCovid == .SinContestar) {
                lblRetroContagio.isHidden = false
                lblRetroContagio.text = "*Es necesario contestar la pregunta"
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.vwInfoGeneral.alpha = 0.0
                    self.vwVacuna.alpha = 0.0
                    self.vwPreguntas.alpha = 0.0
                    self.vwSintomas.alpha = 1.0
                    self.estadoEncuesta = .Sintomas
                    self.pvProgresoEncuesta.progress = 0.5
                })
                
            }
            
        case .Sintomas:
            UIView.animate(withDuration: 0.3, animations: {
                self.vwInfoGeneral.alpha = 0.0
                self.vwVacuna.alpha = 1.0
                self.vwPreguntas.alpha = 0.0
                self.vwSintomas.alpha = 0.0
                self.estadoEncuesta = .Vacunas
                self.btnSiguiente.setTitle("Enviar", for: .normal)
                self.pvProgresoEncuesta.progress = 0.75
            })
            
            
        case .Vacunas:
            lblRetroVacunado.isHidden = true
            if (vacunado == .SinContestar) {
                lblRetroVacunado.isHidden = false
                lblRetroVacunado.text = "*Es necesario contestar la pregunta"
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.vwInfoGeneral.alpha = 1.0
                    self.vwVacuna.alpha = 0.0
                    self.vwPreguntas.alpha = 0.0
                    self.vwSintomas.alpha = 0.0
                    self.estadoEncuesta = .InformacionGeneral
                    self.btnSiguiente.setTitle("Siguiente", for: .normal)
                    self.pvProgresoEncuesta.progress = 0.0
                })
                
            }
        }
    }
    @IBAction func doTapContagioSi(_ sender: Any) {
        vwSelectedContagioNo.isHidden = true
        vwSelectedContagioSi.isHidden = false
        contactoCovid = .Si
        lblSelectedContagioSi.textColor = UIColor.lightGray
        lblSelectedContagioNo.textColor = UIColor.black
    }
    
    @IBAction func doTapContagioNo(_ sender: Any) {
        vwSelectedContagioNo.isHidden = false
        vwSelectedContagioSi.isHidden = true
        contactoCovid = .No
        lblSelectedContagioSi.textColor = UIColor.black
        lblSelectedContagioNo.textColor = UIColor.lightGray
    }
    @IBAction func doChangeNinguno(_ sender: Any) {
        if (swNinguno.isOn) {
            swPositivo.setOn(false, animated: true)
            swTos.setOn(false, animated: true)
            swDolor.setOn(false, animated: true)
            swFiebre.setOn(false, animated: true)
            swCansancio.setOn(false, animated: true)
        }
    }
    @IBAction func doChangeSintoma(_ sender: UISwitch) {
        
        if (sender.isOn) {
            swNinguno.setOn(false, animated: true)
        }
        
        if (!(swCansancio.isOn) && !(swFiebre.isOn)
            && !(swDolor.isOn) && !(swTos.isOn) && !(swPositivo.isOn)) {
            swNinguno.setOn(true, animated: true)
        }
        //Si se apagaron todos, que prenda el ninguno
        
        
        //Back - SOLO si no tenemos Navigation Controller
        //self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func doTapSiVacuna(_ sender: Any) {
        vwSelectedVacunaNo.isHidden = true
        vwSelectedVacunaSi.isHidden = false
        vacunado = .Si
        lblSelectedVacunaSi.textColor = UIColor.lightGray
        lblSelectedVacunaNo.textColor = UIColor.black
    }
    @IBAction func doTapNoVacuna(_ sender: Any) {
        vwSelectedVacunaNo.isHidden = false
        vwSelectedVacunaSi.isHidden = true
        vacunado = .No
        lblSelectedVacunaSi.textColor = UIColor.black
        lblSelectedVacunaNo.textColor = UIColor.lightGray
    }
    
    @IBAction func doTapAtras(_ sender: Any) {
        switch(estadoEncuesta) {
        case .InformacionGeneral:
            break
            
        case .Preguntas:
            break
            
        case .Sintomas:
            break
            
            
        case .Vacunas:
            break
        }
    }
}

