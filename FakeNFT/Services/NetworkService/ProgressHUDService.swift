//
//  ProgressHUDService.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 14.05.2025.
//

import ProgressHUD

final class ProgressHUDServiceTwo {

    static let shared = ProgressHUDServiceTwo()

    private init() {}

    func show(message: String = "Загрузка...") {
        ProgressHUD.show(message)
    }
    
    func dismiss() {
        ProgressHUD.dismiss()
    }
}
