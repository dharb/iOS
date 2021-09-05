//
//  AdvancedSettingsViewController.swift
//  DuckDuckGo
//
//  Copyright © 2021 DuckDuckGo. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

class AdvancedSettingsViewController: UITableViewController {

    @IBOutlet var labels: [UILabel]!

    private var advancedSettings = AdvancedSettings()

    override func viewDidLoad() {
        super.viewDidLoad()

        applyTheme(ThemeManager.shared.currentTheme)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let theme = ThemeManager.shared.currentTheme
        cell.decorate(with: theme)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = EnumeratedSettingTableViewController<AdvancedSettings.AutoplayMedia>(titleForSetting: { setting in
            return setting.title
        }, settingIsSelected: { [weak self] setting in
            return setting == self?.advancedSettings.autoplayMedia
        }, settingSelectionHandler: { [weak self] setting in
            self?.advancedSettings.autoplayMedia = setting
        })

        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension AdvancedSettingsViewController: Themable {

    func decorate(with theme: Theme) {

        for label in labels {
            label.textColor = theme.tableCellTextColor
        }

        tableView.backgroundColor = theme.backgroundColor
        tableView.separatorColor = theme.tableCellSeparatorColor

        tableView.reloadData()

    }

}