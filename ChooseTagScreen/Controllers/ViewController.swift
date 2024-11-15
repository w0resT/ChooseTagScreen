import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    let items = [ "Design", "Furniture", "HTML", "CSS", "Photography", "Cooking", "Psychology", "Art", "Books", "Philosophy", "Sport", "Interfaces", "Family", "Jazz", "Pets", "Motors", "Interiors", "Pop culture", "Technology", "Blogging", "Architecture", "Fashion", "Media", "Music", "Travel", "Urbanism", "Blues", "Alternative", "Swift", "C++", "Java", "Kotlin"]
    var selectedItems: [Int] = []
    
    // TODO: Factory / Custom
    // MARK: - UI Elements
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: UIControl.State.normal)
        button.setTitleColor(Colors.white, for: UIControl.State.normal)
        button.titleLabel?.font = Fonts.bold
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose Your Сourses"
        label.textColor = Colors.white
        label.font = Fonts.title
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "There is always a way to describe your special forces"
        label.textColor = Colors.white
        label.font = Fonts.regular
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 14
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start new adventure →", for: UIControl.State.normal)
        button.setTitleColor(Colors.white, for: UIControl.State.normal)
        button.titleLabel?.font = Fonts.bold
        button.backgroundColor = Colors.blue
        button.layer.cornerRadius = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var topGradientOverlay: UIView = {
        let overlay = UIView(frame: CGRect(x: collectionView.frame.minX,
                                           y: collectionView.frame.minY,
                                           width: collectionView.frame.width,
                                           height: 50))
        overlay.isUserInteractionEnabled = false

        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.frame = overlay.bounds

        overlay.layer.addSublayer(gradient)
        return overlay
    }()

    private lazy var bottomGradientOverlay: UIView = {
        let overlay = UIView(frame: CGRect(x: collectionView.frame.minX,
                                           y: collectionView.frame.maxY - 50,
                                           width: collectionView.frame.width,
                                           height: 50))
        overlay.isUserInteractionEnabled = false

        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.frame = overlay.bounds

        overlay.layer.addSublayer(gradient)
        return overlay
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        setupGradients()
    }
}

// MARK: - Setup UI
private extension ViewController {
    func setupUI() {
        self.view.backgroundColor = Colors.black
        
        setupSkipButton()
        setupTextStack()
        setupCollectionView()
        setupStartButton()
    }
    
    func setupSkipButton() {
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26)
        ])
    }
    
    func setupTextStack() {
        view.addSubview(textStack)
        
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            textStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            textStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            textStack.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 58)
        ])
    }
    
    func setupCollectionView() {
        // Setup
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "itemCell")
        
        // Layout
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 45),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
        ])
    }
    
    func setupStartButton() {
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 45),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    func setupGradients() {
        view.addSubview(topGradientOverlay)
        view.addSubview(bottomGradientOverlay)

        updateGradients(for: collectionView)
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCell
        let currentItem = items[indexPath.item]
        let isSelected = selectedItems.contains(indexPath.item)
        
        cell.configure(text: currentItem, isSelected: isSelected)
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItemIdx = indexPath.item
        if let idx = selectedItems.firstIndex(of: selectedItemIdx) {
            selectedItems.remove(at: idx)
        } else {
            selectedItems.append(selectedItemIdx)
        }
        
        UIView.performWithoutAnimation {
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        updateGradients(for: collectionView)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentItem = items[indexPath.item]
        let size = getItemSize(text: currentItem, font: Fonts.bold14)
        return size
    }
}

// MARK: - Custom UICollectionViewFlowLayout
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        var modifiedAttributes = [UICollectionViewLayoutAttributes]()
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        for attribute in attributes {
            let copiedAttribute = attribute.copy() as! UICollectionViewLayoutAttributes
            if copiedAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            copiedAttribute.frame.origin.x = leftMargin
            leftMargin += copiedAttribute.frame.width + minimumInteritemSpacing
            maxY = max(copiedAttribute.frame.maxY, maxY)
            
            modifiedAttributes.append(copiedAttribute)
        }
        
        return modifiedAttributes
    }
}

// MARK: - Helpers
private extension ViewController {
    func getItemSize(text: String, font: UIFont?) -> CGSize {
        let label = UILabel()
        label.text = text
        label.font = font
        label.sizeToFit()
        let size = label.frame.size
        return CGSize(width: size.width + 18, height: size.height + 14)
    }
    
    func updateGradients(for collectionView: UICollectionView) {
        let contentOffsetY = collectionView.contentOffset.y
        let contentHeight = collectionView.contentSize.height
        let frameHeight = collectionView.frame.height

        // TODO: Плавный переход в зависимости от contentOffsetY
        let topAlpha: CGFloat = contentOffsetY > 0 ? 1 : 0
        let bottomAlpha: CGFloat = (contentOffsetY + frameHeight) < contentHeight ? 1 : 0

        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut, .allowUserInteraction]) {
            self.topGradientOverlay.alpha = topAlpha
            self.bottomGradientOverlay.alpha = bottomAlpha
        }
    }
}
