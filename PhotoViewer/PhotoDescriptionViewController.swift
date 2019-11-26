//
//  PhotoDescriptionViewController.swift
//  PhotoViewer
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from urlString: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}

class PhotoDescriptionViewController: UIViewController {
    
    var photo: Photo?
    @IBOutlet var navigationBar: UINavigationBar?
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let topItem = navigationBar?.topItem {
            topItem.title = "Photo Description"
        }
        
        photoImage.downloadImage(from: photo?.url ?? "")
        photoTitle.text = photo?.title
    }
}

extension PhotoDescriptionViewController {
    
    // MARK: - UIBarbutton action handler
    
    @IBAction func photoListButtonAction(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
