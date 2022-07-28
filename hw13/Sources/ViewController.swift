//
//  ViewController.swift
//  hw13
//
//  Created by Nikolai Kamenshchikov on 23/7/22.
//

import UIKit

struct Section {
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self,
                       forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self,
                       forCellReuseIdentifier: SwitchTableViewCell.identifier)
        
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Настройки"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    // MARK: Functions
    
    
    func configure() {
        
        models.append(Section(options: [
            .switchCell(model: SettingsSwitchOption(title: "Авиарежим", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemOrange, handler: {
            }, isOn: false)),
            
                .staticCell(model: SettingsOption(title: "Wi-Fi", icon: UIImage(systemName: "wifi"), iconBackgroundColor: .systemBlue) {
                }),
            
                .staticCell(model: SettingsOption(title: "Bluetooth", icon: UIImage(imageLiteralResourceName: "bluetoothIconWhite.png"), iconBackgroundColor: .systemBlue) {
                }),
            
                .staticCell(model: SettingsOption(title: "Сотовая связь", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackgroundColor: .systemGreen) {
                }),
            
                .staticCell(model: SettingsOption(title: "Режим модема", icon: UIImage(systemName: "personalhotspot"), iconBackgroundColor: .systemGreen) {
                }),
            
                .switchCell(model: SettingsSwitchOption(title: "VPN", icon: UIImage(imageLiteralResourceName: "vpnIcon.png"), iconBackgroundColor: .systemBlue, handler: {
                }, isOn: false))
        ]))
        
        
        models.append(Section(options: [
            .staticCell(model: SettingsOption(title: "Уведомления", icon: UIImage(systemName: "app.badge"), iconBackgroundColor: .systemRed) {
            }),
            
                .staticCell(model: SettingsOption(title: "Звуки, тактильные сигналы", icon: UIImage(systemName: "speaker.wave.3.fill"), iconBackgroundColor: .systemPink) {
                }),
            
                .staticCell(model: SettingsOption(title: "Не беспокоить", icon: UIImage(systemName: "moon.fill"), iconBackgroundColor: .systemIndigo) {
                }),
            
                .staticCell(model: SettingsOption(title: "Экранное время", icon: UIImage(systemName: "hourglass"), iconBackgroundColor: .systemIndigo) {
                })
        ]))
        
        
        models.append(Section(options: [
            .staticCell(model: SettingsOption(title: "Основные", icon: UIImage(systemName: "gear"), iconBackgroundColor: .systemGray) {
            }),
            
                .staticCell(model: SettingsOption(title: "Пункт управления", icon: UIImage(systemName: "switch.2"), iconBackgroundColor: .systemGray) {
                    
                }),
            
                .staticCell(model: SettingsOption(title: "Экран и яркость", icon: UIImage(systemName: "textformat.size"), iconBackgroundColor: .systemBlue) {
                }),
            
                .staticCell(model: SettingsOption(title: "Экран Домой", icon: UIImage(imageLiteralResourceName: "homeScreenIcon.png"), iconBackgroundColor: .systemIndigo) {
                }),
            
                .staticCell(model: SettingsOption(title: "Универсальный доступ", icon: UIImage(systemName: "figure.wave.circle"), iconBackgroundColor: .systemBlue) {
                })
        ]))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingTableViewCell.identifier,
                for: indexPath
            ) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self {
        case .staticCell(let model):
            model.handler()
            print("Нажата ячейка \(model.title)")
        case .switchCell(let model):
            model.handler()
            print("Нажата ячейка \(model.title)")
        }
    }
}
