//
//  ViewController.swift
//  Swift-Assignment7-NavbarAnimation
//
//  Created by Uji Saori on 2021-01-15.
//

import UIKit

// to pass which image tapped
class ImageTapGesture: UITapGestureRecognizer {
    var imageName = String()
}

class ViewController: UIViewController {
    
    let navbarView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(hex: "#DDDDDD")
        
        return v
    }()
    
    let navbarTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "SNACKS";
        lbl.tintColor = .black
        lbl.font = UIFont.systemFont(ofSize: 25)
        return lbl
    }()
    
    let addBtn: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("＋", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        b.setTitleColor(.systemBlue, for: .normal)
        return b
    }()
    
    let imgView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        iv.contentMode = .scaleAspectFit
       
        return iv
    }()
    
    let tv: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // Navbar height constraint
    let defaultNavbarHeight = CGFloat(88)
    let expandNavbarHeight = CGFloat(200)
    lazy var navbarHeightConstraint = navbarView.heightAnchor.constraint(equalToConstant: defaultNavbarHeight)
    
    var subviewHSV = UIStackView()
    var oreos = UIImageView()
    var pizzaPockets = UIImageView()
    var popTarts = UIImageView()
    var popsicle = UIImageView()
    var ramen = UIImageView()
    
    // Clicked snacks
    var clickedSnacks: [String] = [] {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    private func initUI() {
        // Navbar
        view.addSubview(navbarView)
        NSLayoutConstraint.activate([
            navbarHeightConstraint,
            navbarView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        // Title
        navbarView.addSubview(navbarTitleLabel)
        NSLayoutConstraint.activate([
            navbarTitleLabel.centerXAnchor.constraint(equalTo: navbarView.centerXAnchor),
            navbarTitleLabel.topAnchor.constraint(equalTo: navbarView.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        
        
        // Images: hide at first
        subviewHSV = generateHStackView()
        navbarView.addSubview(subviewHSV)
        subviewHSV.matchParent(padding: .init(top: 100, left: 16, bottom: 8, right: 50))
        subviewHSV.isHidden = true
        
        // Button
        navbarView.addSubview(addBtn)
        NSLayoutConstraint.activate([
            addBtn.trailingAnchor.constraint(equalTo: navbarView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            addBtn.topAnchor.constraint(equalTo: navbarView.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        self.addBtn.addTarget(self, action: #selector(addBtnTapped(_:)), for: .touchUpInside)
        
        
        // TableView
        view.addSubview(tv)
        NSLayoutConstraint.activate([
            tv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            tv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tv.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tv.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
        
    }
    
    @objc func addBtnTapped(_ sender: UIButton) {
        // Update Navbar
        if navbarHeightConstraint.constant == defaultNavbarHeight {
            // Images
            subviewHSV.isHidden = false
            
            // expand
            navbarHeightConstraint.constant = expandNavbarHeight
            UIView.animate(withDuration: 0.5) {
                self.addBtn.transform = CGAffineTransform(rotationAngle: .pi / 4)
                self.view.layoutIfNeeded()
            }
            
        } else {
            // Images
            subviewHSV.isHidden = true
            
            // close
            navbarHeightConstraint.constant = defaultNavbarHeight
            UIView.animate(withDuration: 0.5) {
                self.addBtn.transform = CGAffineTransform(rotationAngle: .pi / 4)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func generateHStackView() -> HorizontalStackView {
        // Images
        oreos = generateImageView(imageName: "oreos")
        pizzaPockets = generateImageView(imageName: "pizza_pockets")
        popTarts = generateImageView(imageName: "pop_tarts")
        popsicle = generateImageView(imageName: "popsicle")
        ramen = generateImageView(imageName: "ramen")

        let hStackView = HorizontalStackView(arrangedSubviews: [
            oreos,
            pizzaPockets,
            popTarts,
            popsicle,
            ramen,
        ], spacing: 16, alignment: .fill, distribution: .fillEqually)
        return hStackView
    }
    
    func generateImageView(imageName: String) -> UIImageView {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let image = UIImage(named: imageName);
        iv.image = image;
        iv.contentMode = .scaleToFill
        
        // Tap gesture
        let tap = ImageTapGesture.init(target: self, action: #selector(imageTapped(_:)))
        tap.imageName = imageName
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }
    
    @objc func imageTapped(_ sender:ImageTapGesture) {
        print("tapped: \(sender.imageName)")
//        clickedSnacks.append(sender.imageName)
//        self.tv .beginUpdates()
//        self.tv.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
//        self.tv .endUpdates()
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clickedSnacks.count
    }
    
    
    
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                // RGBA
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            } else if hexColor.count == 6 {
                // RGB + Alpha=1.0
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x000000ff) / 255
                    a = CGFloat(1.0)
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
