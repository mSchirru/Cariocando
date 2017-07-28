//
//  TableViewCell_Listas.swift
//  Cariocando
//
//  Created by Mikael Schirru on 09/10/16.
//  Copyright © 2016 Mikael Schirru. All rights reserved.
//

import UIKit

class TableViewCell_Listas: UITableViewCell {
    
    
    @IBOutlet var imagemLista: UIImageView!
    
    
    @IBOutlet var labelListas: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
