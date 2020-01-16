//
//  PIHomeDetailsViewController.swift
//  MyDocTask
//
//  Created by mahesh.varadara on 14/1/20.
//  Copyright (c) 2020 mahesh.varadara. All rights reserved.
//

import UIKit

final class PIHomeDetailsViewController: PIViewController {

    @IBOutlet weak var labelArtistTitle: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    var output: PPHomeDetailsInteractorInput?
    var router: PPHomeDetailsRouterProtocol?
    // MARK: - Initializers
    var trackDetail: PVMTracks?

  
    // MARK: - Configurator
   init(configurator: PPBaseConfig =
        PCRHomeDetailsConfigurator.sharedInstance) {
        super.init()
        configure(configurator: configurator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    // MARK: - Configurator
    private func configure(configurator: PPBaseConfig = PCRHomeDetailsConfigurator.sharedInstance) {
        configurator.configure(viewController: self)
    }
    
    deinit {
        //dealloc called
    }
    override func setupViews() {
        super.setupViews()
        labelArtistTitle.text = trackDetail?.artistName
        let image = ImageFromPath()
        let newImage = image.getImageFromPath(imagePath: trackDetail?.trackImage)
        trackImageView.image = newImage
        output?.doSomething()

    }
}

// MARK: - PPHomeDetailsPresenterOutput

extension PIHomeDetailsViewController: PPHomeDetailsPresenterOutput {

    func display(with viewModel: PVMHomeDetailsViewModel) {
        DispatchQueue.main.async {
//            self?.contentView.vm = viewModel
        }
    }
}

