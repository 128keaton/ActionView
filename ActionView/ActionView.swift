//
//  ActionView.swift
//  ActionView
//
//  Created by Keaton Burleson on 4/15/17.
//  Copyright © 2017 Keaton Burleson. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class AnimatedSelectionView: UITableViewController {
    fileprivate var showCancel = true
    fileprivate var tableData: [[String: Any]] = []
    fileprivate var indexPaths: [IndexPath] = []
    fileprivate var inViewController: UIViewController? = nil
    fileprivate var cancelTag: Int? = nil
    
    public var delegate: AnimatedSelectionViewDelegate!
    public var backgroundColor: UIColor = UIColor.clear
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        AnimatedCell.animate(cell: cell)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorColor = UIColor.clear
        self.tableView.isScrollEnabled = false
    }
    
    init(labels: [String], colors: [UIColor], labelColors: [UIColor], showCancel: Bool, inViewController: UIViewController) {
        super.init(style: .plain)
        if labels.count != colors.count {
            print("labels and colors must match count")
            return
        }
        for label in labels {
            let index = labels.index(of: label)
            let indexPath = IndexPath(row: index!, section: 0)
            indexPaths.append(indexPath)
            tableData.append(["label": label, "color": colors[index!], "labelColor": labelColors[index!], "index": index!])
        }
        if self.showCancel == true {
            let index = self.tableData.count
            let indexPath = IndexPath(row: index, section: 0)
            indexPaths.append(indexPath)
            cancelTag = index
            tableData.append(["label": "Cancel", "color": UIColor.red, "labelColor": UIColor.white,  "index": index])
        }
        
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .coverVertical
        self.tableView.insertRows(at: indexPaths, with: .automatic)
        self.inViewController = inViewController
    }
    
    public func show() {
        inViewController?.present(self, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(self.view.frame.height) / tableData.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellHeight = Int(self.view.frame.height) / tableData.count
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: CGFloat(cellHeight)))
        let cellData = tableData[indexPath.row]
        cell.backgroundColor = cellData["color"] as? UIColor
        cell.textLabel?.text = cellData["label"] as? String
        cell.tag = cellData["index"] as! Int
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 35, weight: UIFontWeightMedium)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = cellData["labelColor"] as? UIColor
        
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cancelTag == indexPath.row {
            // user tapped cancel
            self.dismiss(animated: true, completion: nil)
        }
        if self.delegate != nil {
            delegate.didSelectCellAt(index: indexPath.row)
        }
    }
}
// MARK: - Delegate Methods
protocol AnimatedSelectionViewDelegate {
    func didSelectCellAt(index: Int)
}
// MARK: - CATransformations


class AnimatedCell: UITableViewCell {
    class func animate(cell: UITableViewCell) {
        var transformTranslation = -190
        for _ in 0...cell.tag {
            transformTranslation += 30
        }
        cell.transform = CGAffineTransform(translationX: 0, y: CGFloat(transformTranslation))
        UIView.animate(withDuration: 0.6) {
            cell.transform = CGAffineTransform.identity
            
        }
    }
}
