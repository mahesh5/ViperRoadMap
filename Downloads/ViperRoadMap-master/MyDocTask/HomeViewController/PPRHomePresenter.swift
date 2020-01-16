//
//  PPRHomePresenter.swift
//  MyDocTask
//
//  Created by mahesh.varadara on 10/1/20.
//  Copyright (c) 2020 mahesh.varadara. All rights reserved.
//

import Foundation

protocol PPHomePresenterInput {
    func presentData(vm: PVMHomeViewModel)
    func displayErrorMessage(message: String)
}

protocol PPHomePresenterOutput: AnyObject {
    func displayPlayList(with viewModel: PVMHomeViewModel)
    func displayErrorMessage(message: String)
}

final class PPRHomePresenter {

    private(set) weak var output: PPHomePresenterOutput?

    // MARK: - Initializers

    init(output: PPHomePresenterOutput) {
        self.output = output
    }
}

// MARK: - PPHomePresenterInput

extension PPRHomePresenter: PPHomePresenterInput {
    func displayErrorMessage(message: String) {
        output?.displayErrorMessage(message: message)
    }
    
    func presentData(vm: PVMHomeViewModel) {
        output?.displayPlayList(with: vm)
    }
    

    // MARK: - Presentation logic
    func showSpinner() {
//        output?.showSpinner()
    }

    func hideSpinner() {
//        output?.hideSpinner()
    }

    func display(_ error: Error?) {
      //  let viewModel = PVMHomeViewModel()
       // output?.display(with: viewModel)
    }

    func presentData() {
       // let viewModel = PVMHomeViewModel()
       // output?.display(with: viewModel)
    }
}
