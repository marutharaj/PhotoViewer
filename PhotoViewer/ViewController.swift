//
//  ViewController.swift
//  PhotoViewer
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var photoTableView: UITableView!
    
    var viewModel: PhotoViewModelProtocol! {
        didSet {
            viewModel.didReceivePhoto = { [unowned self] viewModel in
                self.activityIndicator.removeFromSuperview()
                self.photoTableView.reloadData()
            }
            
            viewModel.didReceivePhotoFailed = { [unowned self] error in
                self.activityIndicator.removeFromSuperview()
                self.showAlert(message: "Unable to get photos")
            }
        }
    }
    
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = PhotoViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getPhotos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as? PhotoDescriptionViewController
        let photoIndex = photoTableView.indexPathForSelectedRow!.row
        viewController?.photo = viewModel.photos[photoIndex]
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCellId", for: indexPath)
        
        return viewModel.cellForRowAt(indexPath: indexPath, for: cell)
    }
}

fileprivate extension ViewController {
    
    // MARK: - Private Methods
    
    func showActivityIndicator() {
        // Add it to the view where you want it to appear
        view.addSubview(activityIndicator)
        
        // Set up its size (the super view bounds usually)
        activityIndicator.frame = view.bounds
        // Start the loading animation
        activityIndicator.startAnimating()
    }
    
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: "Photos Viewer",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: { (_) in }))
        present(alert,
                animated: true,
                completion: {})
    }
}
