//
//  PhotoViewModel.swift
//  PhotoViewer
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

protocol PhotoViewModelProtocol: class {
    var photos: [Photo] { get set }
    var didReceivePhoto: ((PhotoViewModelProtocol)->())? { get set }
    var didReceivePhotoFailed: ((Error)->())? { get set }
    func getPhotos()
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath, for cell: UITableViewCell) -> UITableViewCell
}

class PhotoViewModel: PhotoViewModelProtocol {
    
    var photos = [Photo]() {
        didSet {
            self.didReceivePhoto?(self)
        }
    }
    
    var didReceivePhoto: ((PhotoViewModelProtocol)->())?
    var didReceivePhotoFailed: ((Error)->())?
    
    func getPhotos() {
        ServiceManager.shared.getPhotos(success: { photos in
            self.photos = photos
        }) { error in
            self.didReceivePhotoFailed?(error)
        }
    }
    
    // MARK: - Photo list data provider
    
    func numberOfSections() -> Int {
        
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        
        return photos.count
    }
    
    func cellForRowAt(indexPath: IndexPath, for cell: UITableViewCell) -> UITableViewCell {
        
        cell.textLabel?.text = photos[indexPath.row].title

        return cell
    }
}

