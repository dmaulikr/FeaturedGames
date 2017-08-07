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
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    lazy var viewModel: GameDetailViewModel = GameDetailViewModel()
    private var screenID: String {
        return String(describing: GameDetailTableViewController.self)
    }
    
    // MARK: VC Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GameDetailCellType(row: indexPath.row).height
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
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
        tableView.registerCell(identifier: String(describing: GameDetailNameTableViewCell.self))
    }
    
    private func fillGameDetailImageCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell: GameDetailImageTableViewCell = UITableViewCell.createCell(tableView: tableView, indexPath: indexPath)
        cell.fill(imageURL: viewModel.gameImage)
        cell.accessibilityIdentifier = "\(screenID).\(String(describing: GameDetailImageTableViewCell.self)).section_\(indexPath.section).row_\(indexPath.row))"
        return cell
    }
    
    private func fillGameDetailNameCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell: GameDetailNameTableViewCell = UITableViewCell.createCell(tableView: tableView, indexPath: indexPath)
        cell.fill(name: viewModel.gameName)
        cell.accessibilityIdentifier = "\(screenID).\(String(describing: GameDetailNameTableViewCell.self)).section_\(indexPath.section).row_\(indexPath.row))"
        return cell
    }
    
    private func fillGameDetailInfosCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell: GameInfosTableViewCell = UITableViewCell.createCell(tableView: tableView, indexPath: indexPath)
        cell.fill(infos: viewModel.gameInfos)
        cell.accessibilityIdentifier = "\(screenID).\(String(describing: GameInfosTableViewCell.self)).section_\(indexPath.section).row_\(indexPath.row))"
        return cell
    }
    
    // MARK: Transporter
    
    func prepareForNavigation(transporter: Transporter<Any>) {
        viewModel.prepareForNavigation(transporter: transporter)
    }
    
    // MARK: Share
    
    @IBAction func shareGame() {
        guard let shareData = viewModel.shareData else {
            return
        }
        let activityController = UIActivityViewController(activityItems: [shareData], applicationActivities: nil)
        DispatchQueue.main.safeAsync {
            self.showLoader(with: "compartilhando...".localized)
            self.present(activityController, animated: true, completion: {
                self.stopLoader()
            })
        }
    }
}
