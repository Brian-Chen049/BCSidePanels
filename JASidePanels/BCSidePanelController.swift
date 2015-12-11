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
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    _layoutSideContainers(false, duration: 0.0)
    _layoutSidePanels()
    styleContainer(centerPanelContainer, animate: false, duration: 0.0)
  }
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    _adjustCenterFrame()
  }
  
  override func _swapCenter(previous: UIViewController!, previousState: JASidePanelState, with next: UIViewController!) {
    
    if let _ = previous where previous != next {
      previous.willMoveToParentViewController(self)
      previous.view.removeFromSuperview()
      previous.removeFromParentViewController()
    }
    
    if let _ = next {
      _loadCenterPanelWithPreviousState(previousState)
      addChildViewController(next)
      centerPanelContainer.addSubview(next.view)
      next.didMoveToParentViewController(self)
    }
  }
  
  override func _loadCenterPanelWithPreviousState(previousState: JASidePanelState) {
    _placeButtonForLeftPanel()
    if style == JASidePanelMultipleActive {
      switch (previousState) {
      case JASidePanelLeftVisible:
        var frame = centerPanelContainer.frame
        frame.size.width = view.bounds.size.width
        centerPanelContainer.frame = frame
        
      case JASidePanelRightVisible:
        var frame = centerPanelContainer.frame
        frame.origin.x = -rightVisibleWidth
        
      default:
        break
      }
    }
    centerPanel.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    centerPanel.view.frame = centerPanelContainer.bounds
    stylePanel(centerPanel.view)
  }
  
  override func _adjustCenterFrame() -> CGRect {
    var frame = view.bounds
    switch (state) {
    case JASidePanelCenterVisible:
      frame.origin.x = 0.0;
      if style == JASidePanelMultipleActive {
        frame.size.width = view.bounds.size.width
      }
    case JASidePanelLeftVisible:
      frame.origin.x = leftVisibleWidth;
      if style == JASidePanelMultipleActive {
        frame.size.width = view.bounds.size.width - leftVisibleWidth
      }
    case JASidePanelRightVisible:
      frame.origin.x = -rightVisibleWidth
      if style == JASidePanelMultipleActive {
        frame.origin.x = 0.0
        frame.size.width = view.bounds.size.width - rightVisibleWidth
      }
    default:
      break
    }
    centerPanelRestingFrame = frame
    return centerPanelRestingFrame
  }
  
  override func toggleLeftPanel(sender: AnyObject!) {
    if state == JASidePanelLeftVisible {
      showCenterPanelAnimated(true)
    } else if state == JASidePanelCenterVisible {
      showLeftPanelAnimated(true)
    }
  }
  
  override func toggleRightPanel(sender: AnyObject!) {
    if state == JASidePanelRightVisible {
      showCenterPanelAnimated(true)
    } else if state == JASidePanelCenterVisible {
      showRightPanelAnimated(true)
    }
  }
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if context == &ja_kvoContext {
      if keyPath == "view" {
        if centerPanel.isViewLoaded() && recognizesPanGesture {
          addPanGestureToView(centerPanel.view)
        } else if keyPath! == "viewCtrollers" && centerPanel === object {
          // view controllers have changed, need to replace the button
           _placeButtonForLeftPanel()
        }
      }
    } else {
      super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
    }
  }
  
  func addPanGestureToView(view:UIView) {
    let panGesture = UIPanGestureRecognizer(target: self, action: "_handlePan")
    panGesture.delegate = self
    panGesture.maximumNumberOfTouches = 1
    panGesture.minimumNumberOfTouches = 1
    view .addGestureRecognizer(panGesture)
  }
  
  override func _placeButtonForLeftPanel() {
    if let _ = leftPanel {
      var buttonController = centerPanel
      if buttonController.isKindOfClass(UINavigationController) {
        let nav = buttonController as! UINavigationController
        if nav.viewControllers.count > 0 {
          buttonController = nav.navigationBar[0]
        }
      }
    }
  }
  
//  - (void)_placeButtonForLeftPanel {
//  if (self.leftPanel) {
//  UIViewController *buttonController = self.centerPanel;
//  if ([buttonController isKindOfClass:[UINavigationController class]]) {
//  UINavigationController *nav = (UINavigationController *)buttonController;
//  if ([nav.viewControllers count] > 0) {
//  buttonController = [nav.viewControllers objectAtIndex:0];
//  }
//  }
//  if (!buttonController.navigationItem.leftBarButtonItem) {
//  buttonController.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];
//  }
//  }
//  }
}

