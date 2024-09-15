//
//  Puzzle.swift
//  MyWorldApp
//
//  Created by 김나연 on 7/25/24.
//

import UIKit
import SnapKit

class PuzzleViewCell: UICollectionViewCell {
    
    static let identifier = "PuzzleViewCell"
    
    private lazy var puzzleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var puzzleCount: UILabel = {
        let t = UILabel()
        t.font = UIFont.systemFont(ofSize: 12)
        return t
    }()
    
    private lazy var puzzleStackGroup: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [puzzleImage, puzzleCount])
        stack.spacing = 9.18
        stack.axis = .horizontal
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAllProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Exit..")
    }
    
    private func addAllProperty() {
        contentView.addSubview(puzzleStackGroup)
        makeConstraints()
    }
    
    private func makeConstraints() {
        puzzleImage.snp.makeConstraints { make in
            make.width.height.greaterThanOrEqualTo(20.82)
        }
        puzzleStackGroup.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    public func addData(model: PuzzleItem) {
        self.puzzleImage.image = model.puzzleImg
        self.puzzleCount.text = "\(model.puzzleCount)개"
    }
}
