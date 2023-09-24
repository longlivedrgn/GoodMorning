//
//  RootViewControllerFactory.swift
//  GoodMorning
//
//  Created by Miro on 2023/09/24.
//

import UIKit

struct RootViewControllerFactory {

  var rootViewController: UIViewController {
    if shouldDisplayOnboardingScreen() {
      return makeOnboardingScreen()
    } else {
      return makeHomeScreen()
    }
  }

  private func shouldDisplayOnboardingScreen() -> Bool {
      // Onboarding을 열어야되는 지 로직 추가하기!..
      return true
  }

  private func makeOnboardingScreen() -> UIViewController {
    return OnBoardingViewController()
  }

  private func makeHomeScreen() -> UIViewController {
      return HomeViewController()
  }

}
