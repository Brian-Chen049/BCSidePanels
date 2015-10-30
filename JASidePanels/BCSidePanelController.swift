//
//  BCSidePanelController.swift
//  Brian Chen
//
//  Created by Brain Chen on 10/28/15.
//
//

import UIKit

class BCSidePanelController: JASidePanelController {
  
//  var leftPanel: UIViewController?
//  var centerPanel: UIViewController?
//  var rightPanel: UIViewController?
//
//  
//  // show the panels
//  func showLeftPanel(animated:Bool)
//  func showRightPanel(animated:Bool)
//  func showCenterPanel(animated:Bool)
//
//  
//  // toggle them opened/closed
//  func toggleLeftPanel(id:sender)
//  func toggleRightPanel(id:sender)



  //  [self _swapCenter:nil previousState:0 with:_centerPanel];
  //  [self.view bringSubviewToFront:self.centerPanelContainer];
  //  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    centerPanelContainer = UIView(frame: view.bounds)
    centerPanelRestingFrame = centerPanelContainer.frame
    centerPanelHidden = false
    
    leftPanelContainer = UIView(frame: view.bounds)
    leftPanelContainer.hidden = true
    
    rightPanelContainer = UIView(frame: view.bounds)
    rightPanelContainer.hidden = true
    
    self._configureContainers()
    view.addSubview(centerPanelContainer)
    view.addSubview(leftPanelContainer)
    view.addSubview(rightPanelContainer)
    
    state = JASidePanelCenterVisible
    
    _swapCenter(nil, previousState: JASidePanelState(0), with: centerPanel)
    view.bringSubviewToFront(centerPanelContainer)
  }

}
