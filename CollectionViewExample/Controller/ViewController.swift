//
//  ViewController.swift
//  CollectionViewExample
//
//  Created by IMCS2 on 1/10/20.
//  Copyright © 2020 IMCS2. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    var artistNames:[String] = []
    var artistArtworks:[UIImage] = []
    
    let obj = APICall()
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artistNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:
            indexPath) as! CollectionViewCell
    
        
        let name = artistNames[indexPath.row]
        let image = artistArtworks[indexPath.row]
        
        
        cell.txtLabel.text = name
        cell.imgLbl.image = image
        
        
        
        cell.txtLabel.textColor = UIColor.yellow
        
        
      //  cell.imgLbl.layer.cornerRadius = 100  // corner radius for UIImageView
        cell.imgLbl.layer.borderColor = UIColor.orange.cgColor // border color as CGCOLOR is important
        cell.imgLbl.layer.borderWidth = 3  // border width for ImageView
        cell.imgLbl.clipsToBounds = true // needed because without this radius effect wont work
        
//        cell.layer.cornerRadius = 25  // corner radius for Table View Cell
        cell.layer.borderColor = UIColor.orange.cgColor
        cell.layer.borderWidth = 5
        cell.backgroundColor = UIColor.black
        
        
        return cell
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        obj.APIrequest { (Result: Welcome) in
        
            let feed = Result.feed
            let results = feed.results
            
            results.forEach({ (Result) in
                
                self.artistNames.append(Result.artistName)
                
                let imageUrl = Result.artworkUrl100
                
                guard let url = URL(string: imageUrl) else {return}
                
                if let data = try? Data(contentsOf: url)
                {
                    let image: UIImage = UIImage(data: data)!
                    self.artistArtworks.append(image as UIImage)
                }
                
            })
            
            DispatchQueue.main.async {
                
                do{
                    sleep(3)  // sleep to fetch and convert the images or else it thorws out of bound error
                }
                self.cView.reloadData()
                
            }
        
        }
        
        
        
        cView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        cView.backgroundColor = UIColor.blue
        
    }

    
    @IBOutlet var cView: UICollectionView!
    
    
}

