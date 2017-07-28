//
//  ViewController_ParqueTijuca.swift
//  Cariocando
//
//  Created by Mikael Schirru on 09/10/16.
//  Copyright © 2016 Mikael Schirru. All rights reserved.
//

import UIKit

class ViewController_ParqueTijuca: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var places = NSArray()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let placesPath = Bundle.main.path(forResource: "ParqueTijuca", ofType: "plist") {
            
            if let dic = NSDictionary(contentsOfFile: placesPath) {
                places = dic["places"] as! NSArray
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //cell customizada
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_ParqueTijuca", for: indexPath) as! TableViewCell_Listas    //identificador
        
        if let item:NSDictionary = places[indexPath.row] as? NSDictionary {
            let nome = item["nome"] as! String
            
            let imagem = item["image"] as! String
            
            cell.labelListas.text = nome
            
            cell.imagemLista.image = UIImage(named: imagem)
        }
        
        
        return cell
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            if let indexPath = tableView.indexPathForSelectedRow {
    
                let item = places[(indexPath as NSIndexPath).row]
                print(item)
    
                //Converte no ViewControle do detalhe
                let detailVC = segue.destination as! ViewControllerDetalhesTrilhas
    
                detailVC.dicPlace = item as? NSDictionary
            }
        }
    
}

