//
//  ProgressHudService.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//
import ProgressHUD

final class ProgressHUDService {
    static let shared = ProgressHUDService()
    private init() {}
    
    func showProgress(message: String = "Загрузка...") {
        ProgressHUD.show(message)
    }
    
    func dismiss() {
        ProgressHUD.dismiss()
    }
}
