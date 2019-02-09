/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class ViewControllerAnimation: UIViewController {
    
    //MARK:- IB outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addTrailingConstraint: NSLayoutConstraint!
    
    //MARK:- further class variables
    
    var slider: HorizontalItemList!
    var menuIsOpen = false
    var items: [Int] = [5, 6, 7]
    
    //MARK:- class methods
    
    @IBAction func toggleMenu(_ sender: AnyObject) {
        menuIsOpen = !menuIsOpen
        
        titleLabel.text = menuIsOpen ? "Select Item" : "Packing List"
        view.layoutIfNeeded()
        
        titleLabel.constraints.forEach { constraint in
            if constraint.firstItem === titleLabel && constraint.firstAttribute == .centerX {
                constraint.constant = menuIsOpen ? -1000.0 : 0.0
                return
            }
            
            if constraint.identifier == "TitleCenterY" {
                constraint.isActive = false
                
                let newConstraint = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: titleLabel.superview, attribute: .centerY, multiplier: menuIsOpen ? 0.67 : 1.0, constant: 0)
                newConstraint.identifier = "TitleCenterY"
                newConstraint.priority = .defaultHigh
                newConstraint.isActive = true
            }
            
        }
        
        menuHeightConstraint.constant   =   menuIsOpen ?    200     :       80
        addTrailingConstraint.constant  =   menuIsOpen ?    16      :       8
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
            let angle: CGFloat = self.menuIsOpen ? .pi / 4 : 0.0
            self.buttonMenu.transform = CGAffineTransform(rotationAngle: angle)
            self.view.layoutIfNeeded()
        })
        
    }
    
    func showItem(_ index: Int) {
        let imageView = makeImageView(index: index)
        let containerView = UIView(frame: imageView.frame)
        
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let conX        =   containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let conBottom   =   containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageView.frame.height)
        let conWidth    =   containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33, constant: -50.0)
        let conHeight   =   containerView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        
        let imageY        =   imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        let imageX        =   imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let imageWidth    =   imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor)
        let imageHeight   =   imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        
        NSLayoutConstraint.activate([conX, conBottom, conWidth, conHeight, imageY, imageX, imageWidth, imageHeight])
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            conBottom.constant  =   -imageView.frame.height * 2
            conWidth.constant   =   0.0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        delay(seconds: 1.0) {
            UIView.transition(with: containerView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                imageView.removeFromSuperview()
            }, completion: { (_) in
                containerView.removeFromSuperview()
            })
        }
        
//        UIView.animateKeyframes(withDuration: 0.3, delay: 0.8, animations: {
//            imageView.alpha = 0
//            conBottom.constant  =   imageView.frame.height
//            conWidth.constant   =   -50
//            self.view.layoutIfNeeded()
//        }, completion: { _ in
//            imageView.removeFromSuperview()
//        })
        
    }
    
    func transitionCloseMenu() {
        delay(seconds: 0.35, completion: {
            self.toggleMenu(self)
        })
    }
}

//////////////////////////////////////
//
//   Starter project code
//
//////////////////////////////////////

let itemTitles = ["Icecream money", "Great weather", "Beach ball", "Swim suit for him", "Swim suit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]

// MARK:- View Controller

extension ViewControllerAnimation: UITableViewDelegate, UITableViewDataSource {
    func makeImageView(index: Int) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "summericons_100px_0\(index).png"))
        imageView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func makeSlider() {
        slider = HorizontalItemList(inView: view)
        slider.didSelectItem = {index in
            self.items.append(index)
            self.tableView.reloadData()
            self.transitionCloseMenu()
        }
        self.titleLabel.superview?.addSubview(slider)
    }
    
    // MARK: View Controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeSlider()
        self.tableView?.rowHeight = 54.0
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: Table View methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = .none
        cell.textLabel?.text = itemTitles[items[indexPath.row]]
        cell.imageView?.image = UIImage(named: "summericons_100px_0\(items[indexPath.row]).png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showItem(items[indexPath.row])
    }
    
}
