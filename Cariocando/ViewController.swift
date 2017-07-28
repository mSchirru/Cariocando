//
//  ViewController.swift
//  Cariocando
//
//  Created by Mikael Schirru on 09/10/16.
//  Copyright © 2016 Mikael Schirru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var TiposAtividades: [UIView]! {
        didSet {
            TiposAtividades.forEach {
                $0.isHidden = true
            }
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func SelecionarAtividade(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.3) { 
            self.TiposAtividades.forEach {
                $0.isHidden = !$0.isHidden
            }
        }
    }
}

