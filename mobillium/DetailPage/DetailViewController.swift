//
//  DetailViewController.swift
//  mobillium
//
//  Created by yunus emre coşkun on 2.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var viewModel = DetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.getDetailMovie { model in
            let url = self.viewModel.getImgUrl(model?.backdrop_path ?? "")
            DispatchQueue.main.async {
                
            self.navigationItem.title = model?.title
            let data = try? Data(contentsOf: url!)
            if let data = data {
                    self.imageView.image = UIImage(data: data)
            }
            self.pointLabel.text = String(model?.vote_average ?? 0)
            self.dateLabel.text = self.viewModel.dateFormatter(model?.release_date ?? "")
            self.titleLabel.text = model?.original_title ?? ""
            self.descriptionLabel.text = model?.overview ?? ""
            }
        }
    }
}
