//
//  GameDetailTableViewController.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 06/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import UIKit

class GameDetailTableViewController: UITableViewController {

    // MARK: Properties
    
    lazy var viewModel: GameDetailViewModel = GameDetailViewModel()
    private var screenID: String {
        return String(describing: GameDetailTableViewController.self)
    }
    
    // MARK: VC Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupShareButton()
    }
    
    private func setupShareButton() {
        
    }
    
    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return GameDetailCellType(row: indexPath.row).height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch GameDetailCellType(row: indexPath.row) {
        case .image:
            return fillGameDetailImageCell(tableView: tableView, indexPath: indexPath)
        case .name:
            return fillGameDetailNameCell(tableView: tableView, indexPath: indexPath)
        case .infos:
            return fillGameDetailInfosCell(tableView: tableView, indexPath: indexPath)
        }
    }
    
    // MARK: Cells
    
    private func registerCells() {
        tableView.registerCell(identifier: String(describing: GameDetailImageTableViewCell.self))
    }
    
    private func fillGameDetailImageCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell: GameDetailImageTableViewCell = UITableViewCell.createCell(tableView: tableView, indexPath: indexPath)
        cell.fill(imageURL: viewModel.gameImage)
        cell.accessibilityIdentifier = "\(screenID).\(String(describing: GameDetailImageTableViewCell.self)).section_\(indexPath.section).row_\(indexPath.row))"
        return cell
    }
    
    private func fillGameDetailNameCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    private func fillGameDetailInfosCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: Transporter
    
    func prepareForNavigation(transporter: Transporter<Any>) {
        viewModel.prepareForNavigation(transporter: transporter)
    }
}
