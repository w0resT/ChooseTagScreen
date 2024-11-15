import UIKit

class ItemCell: UICollectionViewCell {
    // MARK: - UI Elements
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.bold14
        label.textColor = Colors.white
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(text: String, isSelected: Bool) {
        textLabel.text = text
        textLabel.textColor = isSelected ? Colors.black : Colors.white
        contentView.backgroundColor = isSelected ? Colors.white : .clear
    }
}

private extension ItemCell {
    func setupUI() {
        contentView.layer.cornerRadius = 14
        contentView.layer.borderColor = Colors.white.cgColor
        contentView.layer.borderWidth = 1
        
        setupTextLabel()
    }
    
    func setupTextLabel() {
        contentView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
