//
//  CategoriesCollectionViewCell.swift
//  RecipeFinder
//
//  Created by Nazlıcan Çay on 26.07.2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoriesCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Colors.BackgroundColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = Colors.BackgroundColor
        label.textColor = Colors.BtnAndTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
       
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.width-50)
        let padding: CGFloat = 10.0
        label.frame = CGRect(x: padding, y: imageView.frame.size.height + padding, width: contentView.frame.size.width - 2 * padding, height: contentView.frame.size.height - imageView.frame.size.height - 2 * padding)
    }

    func configure(with category: Category) {
        label.text = category.strCategory

        guard let url = URL(string: category.strCategoryThumb) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }

            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }

        task.resume()
    }
}
