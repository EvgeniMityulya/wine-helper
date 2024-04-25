//
//  OnboardingViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/25/24.
//

import UIKit

protocol OnboardingInput: AnyObject {
    func changeButtonBackgroundColorWithAlpha(_ sender: UIButton, color: UIColor, alpha: CGFloat)
    func nextCollectionViewItem()
    func slideCollectionViewItem(_ scrollView: UIScrollView)
    func isLastSlide() -> Bool
}

final class OnboardingViewController: UIViewController {
    
    var output: OnboardingViewOutput?
    
    var currentPage = 0 {
        didSet {
            self.updatePageControl()
        }
    }
    
    private enum ButtonText: String {
        case next = "Next"
        case getStarted = "Get Started"
    }
    
    private var slides: [OnboardingSlide] = [
        OnboardingSlide(
            title: "Welcome!",
            desciption: "Welcome to the Wine Helper app! Explore the world of wines with ease and savor every sip!",
            image: UIImage(named: Image.Onboarding.welcome)
        ),
        OnboardingSlide(
            title: "New horizons",
            desciption: "Immerse yourself in the world of diverse grape varieties and discover new wine horizons!",
            image: UIImage(named: Image.Onboarding.newHorizons)
        ),
        OnboardingSlide(
            title: "Advanced category search",
            desciption: "Explore our wine guide with an extensive selection of wines. Use our advanced search to find the perfect wine for you!",
            image: UIImage(named: Image.Onboarding.search)
        ),
        OnboardingSlide(
            title: "Map search",
            desciption: "Discover the best wine establishments in your region using our app. Use the map for convenient searching and enjoy a wide selection of wine venues!",
            image: UIImage(named: Image.Onboarding.map)
        ),
        OnboardingSlide(
            title: "Promotion",
            desciption: "Stay informed about exciting offers and popular wines! Be the first to know about new arrivals and thrilling updates in our app!",
            image: UIImage(named: Image.Onboarding.promotion)
        )
    ]
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(ButtonText.next.rawValue, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.font = UIFont.openSans(ofSize: 19, style: .regular)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        button.backgroundColor = UIColor.CustomColors.burgundy
        button.addTarget(self, action: #selector(nextButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(nextButtonTouchUpInside), for: .touchUpInside)
        button.addTarget(self, action: #selector(nextButtonTouchUpOutside), for: .touchUpOutside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = self.slides.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.currentPageIndicatorTintColor = .burgundy
        return pageControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnboardingSlideCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingSlideCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.CustomColors.background
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}

private extension OnboardingViewController {
    @objc private func nextButtonTouchDown() {
        output?.nextButtonTouchDown(nextButton)
    }
    
    @objc private func nextButtonTouchUpInside() {
        output?.nextButtonTouchUpInside(nextButton)
        
    }
    
    @objc private func nextButtonTouchUpOutside() {
        output?.nextButtonTouchUpOutside(nextButton)
    }
}

extension OnboardingViewController: OnboardingInput {
    func isLastSlide() -> Bool {
        self.currentPage == self.slides.count - 1
    }
    
    func changeButtonBackgroundColorWithAlpha(_ sender: UIButton, color: UIColor, alpha: CGFloat) {
        sender.backgroundColor = color.withAlphaComponent(alpha)
    }
    
    func nextCollectionViewItem() {
        self.currentPage = min(self.currentPage + 1, self.slides.count - 1)
        let indexPath = IndexPath(item: self.currentPage, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func slideCollectionViewItem(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        self.currentPage = Int(scrollView.contentOffset.x / width)
        self.pageControl.currentPage = self.currentPage
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingSlideCollectionViewCell.identifier, for: indexPath) as! OnboardingSlideCollectionViewCell
        cell.configure(with: self.slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        output?.slideCollectionViewInput(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

private extension OnboardingViewController {
    func setupUI() {
        self.view.addSubview(
            self.nextButton,
            self.pageControl,
            self.collectionView
        )
        
        NSLayoutConstraint.activate([
            self.nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.nextButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            self.nextButton.heightAnchor.constraint(equalToConstant: 44),
            
            self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.pageControl.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: -20),
            self.pageControl.widthAnchor.constraint(equalToConstant: 200),
            self.pageControl.heightAnchor.constraint(equalToConstant: 30),
            
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.pageControl.topAnchor, constant: -40),
        ])
    }
    
    private func updatePageControl() {
        self.pageControl.currentPage = self.currentPage
        let buttonText = (self.currentPage == self.slides.count - 1) ? ButtonText.getStarted.rawValue : ButtonText.next.rawValue
        self.nextButton.setTitle(buttonText, for: .normal)
    }
}
