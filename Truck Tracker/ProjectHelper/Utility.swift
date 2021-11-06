//
//  Utility.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import Foundation

//MARK:- Loader
func showLoader()
{
    AppDelegate().sharedDelegate().showLoader()
}

// MARK: - removeLoader
func removeLoader()
{
    AppDelegate().sharedDelegate().removeLoader()
}
