//
//  AirMapFlightSocialCell.swift
//  AirMapSDK
//
//  Created by Adolfo Martinelli on 7/18/16.
//  Copyright © 2016 AirMap, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class AirMapFlightSocialCell: UITableViewCell, Dequeueable {
	
	static let reuseIdentifier = String(AirMapFlightSocialCell)
	
	@IBOutlet weak var toggle: UISwitch!
	@IBOutlet weak var logoImage: UIImageView!
	
	private let disposeBag = DisposeBag()
	
	var model: SocialSharingRow! {
		didSet {
			setupBindings()
			logoImage.image = model.logo
		}
	}
	
	private func setupBindings() {
		model.value
			.asObservable()
			.bindTo(toggle.rx_selected)
			.addDisposableTo(disposeBag)
	}

}
