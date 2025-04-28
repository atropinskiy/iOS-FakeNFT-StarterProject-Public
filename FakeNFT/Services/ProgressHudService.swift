//
//  ProgressHudService.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//
import ProgressHUD

class ProgressHUDService {
    static let shared = ProgressHUDService()
    
    // Показываем ProgressHUD
    func showProgress(message: String = "Загрузка...") {
        ProgressHUD.show(message)
    }
    
    // Скрываем ProgressHUD
    func dismiss() {
        ProgressHUD.dismiss()
    }
}
