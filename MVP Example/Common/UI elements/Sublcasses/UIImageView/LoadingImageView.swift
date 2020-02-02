import UIKit

class LoadingImageView: UIImageView {
    
    private var currentImageUrl: String?
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        self.addSubview(activityIndicator)
        
        return activityIndicator
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicator.frame.size = self.frame.size
    }
    
    func updateWith(url: String?, defaultImage: UIImage? = UIImage(named: "no_image")) {
        self.currentImageUrl = url

        if let url = url {
            self.image = nil
            activityIndicator.startAnimating()
            
            ImageDownloader.shared.downloadImageUsingCache(url: url) { [weak self] imageUrl, image in
                if imageUrl == self?.currentImageUrl {
                    self?.activityIndicator.stopAnimating()
                    self?.image = image ?? defaultImage
                }
            }
        } else {
            self.image = defaultImage
        }
    }
}
