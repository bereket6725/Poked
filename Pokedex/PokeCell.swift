//
//  PokeCell.swift
//  Pokedex
//
//  Created by Bereket Ghebremedhin on 6/26/16.
//  Copyright © 2016 Bereket Ghebremedhin. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {

    @IBOutlet weak var thumbIMG: UIImageView!
    @IBOutlet weak var nameLBL : UILabel!
    
    var pokemon: Pokemon!
    
    
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0 
    }
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        self.nameLBL.text = self.pokemon.name
        self.thumbIMG.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
        
    }
    
}
