//
//  PuzzleItem.swift
//  MyWorldApp
//
//  Created by 김나연 on 7/29/24.
//

import Foundation
import UIKit
struct PuzzleItem{
    var puzzleImg: UIImage?
    var puzzleCount: Int
}
final class PuzzleData{
    static var dataList: [PuzzleItem] = [
        PuzzleItem(puzzleImg: UIImage(named: "Puzzle1"), puzzleCount: 0),
        PuzzleItem(puzzleImg: UIImage(named: "Puzzle2"), puzzleCount: 0),
        PuzzleItem(puzzleImg: UIImage(named: "Puzzle3"), puzzleCount: 0),
        PuzzleItem(puzzleImg: UIImage(named: "Puzzle4"), puzzleCount: 0),
    ]
}
