//
//  QuickLocoViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-01-24.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit
import Foundation
import CoreData

var Businesses = [String:AnyObject]()


struct BusinessDetail{
    let businessName: String
    let businessDescription: String
    let businessType: String
}




class QuickLocoViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imageNames = ["coffee","yoga","restaurant","pizza","hiking","beer"]

    @IBOutlet weak var collectionImage: UIImageView!


    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set section inset as per your requirement.
     //   layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    //
        //set cell item size here
       layout.itemSize = CGSize(width: width / 2, height: width / 2)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 0
        
        //set minimum vertical line spacing here between two lines in collectionview
        layout.minimumLineSpacing = 0
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout

        var nib = UINib(nibName: "collectionViewCellRecommendation", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "collectionViewCellRecommendation")
        
             self.view.ViewBackground(image: "quickLocoBG")

        collectionView.delegate = self
        collectionView.dataSource = self
    //TABLE VIEW
        
    
         }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
      
        }

    
    @available(iOS 6.0, *)
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
    let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCellRecommendation", for: indexPath) as! RecommendCollectionViewCell
    
        
        cell.recommendImage.image = UIImage(named:imageNames[indexPath.row])
        
        
        return cell
        
    }
    
    
    @available(iOS 6.0, *)
    public func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 2
    }


}
