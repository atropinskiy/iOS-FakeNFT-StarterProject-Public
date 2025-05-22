//
//  ProgressHUDService.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 14.05.2025.
//

import ProgressHUD

final class ProgressHUDService {

    static let shared = ProgressHUDService()

    private init() {}

    func show(message: String = "Загрузка...") {
        ProgressHUD.show(message)
    }
    
    func dismiss() {
        ProgressHUD.dismiss()
    }
}
