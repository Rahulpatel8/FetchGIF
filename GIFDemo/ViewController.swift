//
//  ViewController.swift
//  GIFDemo
//
//  Created by SOTSYS024 on 01/06/17.
//  Copyright © 2017 SOTSYS024. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class ViewController: UIViewController {

    var arrAlbumCount = [PHAssetCollection]()
    let me : PHAsset? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userAlbumsOptions = PHFetchOptions()
        userAlbumsOptions.includeAssetSourceTypes = PHAssetSourceType.typeCloudShared
        //FIXME: smartAlbum is used to get camera roll ald other album of system
        let allAlbum = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.any, options: userAlbumsOptions)
        allAlbum.enumerateObjects({ (collection, limit, any) in
            print("album title: \(String(describing: collection.localizedTitle))")
            self.arrAlbumCount.append(collection)
            let onlyImagesOptions = PHFetchOptions()
            let result = PHAsset.fetchAssets(in: collection, options: onlyImagesOptions)
                result.enumerateObjects({ (object, _, _) in
                    PHImageManager.default().requestImageData(for: object, options: nil, resultHandler: { (imageData, UTI, _ , _) in
                        if let uti = UTI,let _ = imageData ,
                            UTTypeConformsTo(uti as CFString, kUTTypeGIF) {
                            //save data
                            print("We get GIF");
                        }
                    })
                })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

