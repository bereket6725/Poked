//
//  ViewController.swift
//  Pokedex
//
//  Created by Bereket Ghebremedhin on 6/26/16.
//  Copyright © 2016 Bereket Ghebremedhin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    //create our array of Pokemon
    var pokemon = [Pokemon]()
    //create music player for pokemon music
    var musicPlayer: AVAudioPlayer!
    //var pokemon: [Pokemon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collection.delegate   = self
        collection.dataSource = self
        searchBar.delegate    = self
        self.parsePokemonCSV()
        initAudio()

        
    }
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    //function pareses the csv file and adds it to our pokemon array that will be used in our colllection view
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows{
                //forcibly unwrapping it is ok THIS TIME because we HAVE the data in a file and are not relying on a network request
                
                let pokeID = Int(row["id"]!)!
                let name   = row["identifier"]
                let poke   = Pokemon(name: name!, pokedexId: pokeID)
                pokemon.append(poke)
            }
            print(rows.description)
            
        }
        catch let err as NSError{
            print(err.debugDescription)
            
        }
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 718
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            //will initialize a pokemon 718 times
            //var pokemon = Pokemon(name: "Test", pokedexId: indexPath.row)
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            
            return cell
        }else{
          return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105,105)
    }
    
    
    @IBAction func musicButtonTapped(sender: AnyObject) {
        if musicPlayer.playing == true
        {
           musicPlayer.stop()
           //sender.alpha = 0.2
        }
        else
        {
           musicPlayer.play()
          // sender.alpha = 1.0
        }
    }
    
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        <#code#>
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

