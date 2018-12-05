//
//  CustomVideoViewModel.swift
//  SwiftVRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

// MARK: - Protocol
protocol CustomVideoViewModelDelegate: class {
  func openButtonEnabledChanged(enabled: Bool)
  func dismisCurrentModule(completion: ((_ finished: Bool) -> Void)?)
}

class CustomVideoViewModel {
  // MARK: - Public properties
  weak var delegate: CustomVideoViewModelDelegate?
  var completionBlock: ((_ pCode: String, _ embedCode: String) -> Void)?

  // MARK: - Private properties
  private var pCode: String = ""
  private var embedCode: String = ""

  // MARK: - Public functions
  func pCodeDidUpdated(pCode: String?) {
    self.pCode = pCode ?? ""
    updateOpenButtonState()
  }

  func embedCodeDidUpdated(embedCode: String?) {
    self.embedCode = embedCode ?? ""
    updateOpenButtonState()
  }

  func openButtonDidTapped() {
    if embedCode != "" && pCode != "" {
      delegate?.dismisCurrentModule(completion: { (_) in
        self.completionBlock?(self.pCode, self.embedCode)
      })
    }
  }

  // MARK: - Private functions
  private func updateOpenButtonState() {
    delegate?.openButtonEnabledChanged(enabled: embedCode != "" && pCode != "")
  }
}
