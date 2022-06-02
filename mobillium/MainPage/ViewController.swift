//
//  ViewController.swift
//  obss
//
//  Created by yunus emre coşkun  on 30.05.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = ViewModel()
    // MARK: variable
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        bindViewModel()
    }
    func prepareCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    func bindViewModel() {
        viewModel.getAllTableModel { model in
            if model != nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        viewModel.getAllCollectionModel { model in
            if let model = model {
                DispatchQueue.main.async {
                    self.viewModel.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
                    self.pageControl.numberOfPages = model.results?.count ?? 0
                    self.pageControl.currentPage = 0
                    self.collectionView.reloadData()
                }
            }
        }
    }
    @objc func changeImage() {
        if viewModel.counter < (self.viewModel.numberOfRowsCollectionModel()) {
            let index = IndexPath.init(item: viewModel.counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = viewModel.counter
            viewModel.counter += 1
        } else {
            viewModel.counter = 0
            let index = IndexPath.init(item: viewModel.counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = viewModel.counter
            viewModel.counter = 1
        }
    }
}

// MARK: segue
extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC" {
            if let detailViewController = segue.destination as? DetailViewController {
                detailViewController.viewModel.movieId = viewModel.movieId
            }
            
        }
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsTableModel()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var value = ""
        if let result = viewModel.selectRowsTableModel(indexPath.row){
            
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            let url = viewModel.getImgUrl(result.backdropPath)
            let data = try? Data(contentsOf: url!)
            if let data = data {
                tableViewCell.imageViews.image = UIImage(data: data)
                tableViewCell.imageViews.contentMode = .scaleAspectFill
                tableViewCell.imageViews.layer.cornerRadius = 15.0
                tableViewCell.imageViews.layer.masksToBounds = true
            }
            tableViewCell.headerLabel.text = result.originalTitle
            tableViewCell.descriptionLabel.text = result.overview
            tableViewCell.dateLabel.text = viewModel.dateFormatter(result.releaseDate)
            return tableViewCell
        }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.movieId = viewModel.selectRowsTableModel(indexPath.row)?.id ?? 0
        performSegue(withIdentifier: "DetailVC", sender: nil)
    }
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsCollectionModel()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let result = viewModel.selectRowsCollectionModel(indexPath.row){
        if let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionViewCell {
            let url = viewModel.getImgUrl(result.backdropPath)
            let data = try? Data(contentsOf: url!)
            if let data = data {
                collectionViewCell.imageView.sizeToFit()
                collectionViewCell.imageView.image = UIImage(data: data)
                collectionViewCell.imageView.contentMode = .scaleAspectFit
            }
            collectionViewCell.headerLabel.text = result.originalTitle
            collectionViewCell.descriptionLabel.text = result.overview
            return collectionViewCell
        }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.movieId = viewModel.selectRowsCollectionModel(indexPath.row)?.id ?? 0
        performSegue(withIdentifier: "DetailVC", sender: nil)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
