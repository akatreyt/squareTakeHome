//
//  EmployeeCellTableViewCell.swift
//  SquareTakeHome
//
//  Created by Trey Tartt on 4/20/21.
//

import UIKit

public final class EmployeeCellTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    
    var imageCache: ImageCache!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func set(employee: Employee, imageCache: ImageCache){
        self.imageCache = imageCache
        nameLabel.text = employee.fullName
        teamLabel.text = employee.team
        
        if let url = URL(string: employee.photoURLSmall) {
            imageCache.getImage(forURL: url) { [weak self] result in
                guard let self = self else { return }
                switch result{
                case .success(let image):
                    self.photoView.image = image
                case .failure(_):
                    self.photoView.image = UIImage(systemName: "photo")
                }
            }
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = UIImage(systemName: "photo")
        nameLabel.text = "N/A"
        teamLabel.text = "N/A"
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
