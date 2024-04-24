//
//  CatalogViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/24/24.
//


import UIKit

protocol CatalogInput: AnyObject {
    
}

final class CatalogViewController: UIViewController {
    
    var output: CatalogViewOutput?
    
    var wines = [WineCellDTO]()
    var images = [UIImage]()
    
    private lazy var searchTextField: UISearchTextField = {
        let searchTextField = UISearchTextField()
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.delegate = self
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
        searchTextField.backgroundColor = UIColor.white
        searchTextField.placeholder = "Search"
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        searchTextField.leftViewMode = .always
        searchTextField.returnKeyType = .go
        searchTextField.textColor = .black
        searchTextField.clearButtonMode = .whileEditing
        
        let paramsButton = UIButton()
        paramsButton.setImage(SystemImage.params.image, for: .normal)
        paramsButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        paramsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        paramsButton.tintColor = .burgundy
        searchTextField.rightView = paramsButton
        searchTextField.rightViewMode = .always
        
        if let placeholder = searchTextField.placeholder {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 16)
            ]
            searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
        return searchTextField
    }()
    
    private lazy var winesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let itemWidth = (UIScreen.main.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right) / 2
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 30
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    @objc func buttonTapped() {
        print(1)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.CustomColors.background
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.shared.getWines(from: 0, to: 20) { [weak self] result in
            switch result {
            case .success(let wineCellDTOs):
                self?.fetchImagesForWineCellDTOs(wineCellDTOs)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchImagesForWineCellDTOs(_ wineCellDTOs: [WineCellDTO]) {
//        specialOfferSection.setLoadingIndicatorVisible(true)
        let dispatchGroup = DispatchGroup()
        
        for wineCellDTO in wineCellDTOs {
            guard let id = wineCellDTO.id else { continue }
            
            dispatchGroup.enter()
            
            NetworkManager.shared.getWineImage(id: id) { result in
                defer { dispatchGroup.leave() }
                
                switch result {
                case .success(let image):
                    self.wines.append(wineCellDTO)
                    self.images.append(image)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Success")
//            section?.setLoadingIndicatorVisible(false)
//            section?.setWines(self.wines, self.images)
        }
    }
}

extension CatalogViewController: CatalogInput {
    
}

extension CatalogViewController: UITextFieldDelegate {
    
}

extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineCell", for: indexPath) as! WineCell
        let wine = self.wines[indexPath.item]
        let image = self.images[indexPath.item]
        cell.configure(with: wine, image: image)
        return cell
    }
}

private extension CatalogViewController {
    func setupUI() {
        self.view.addSubview(
            self.searchTextField,
            self.winesCollectionView
        )
        
        NSLayoutConstraint.activate([
            self.searchTextField.heightAnchor.constraint(equalToConstant: 44),
            self.searchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.searchTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            self.searchTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            self.winesCollectionView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor),
            self.winesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.winesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.winesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
