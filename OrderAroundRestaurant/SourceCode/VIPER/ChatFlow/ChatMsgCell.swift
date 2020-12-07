

import UIKit
class ChatLeftCell : UITableViewCell {
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var msgLabl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var chatUserImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        msgView.layer.cornerRadius = 5
        self.selectionStyle = .none
//         self.msgLabl.textColor = .white
//        self.timeLbl.textColor = .white
        self.msgView.setCorneredElevation(shadow: 1, corner: 10, color: .gray)
//        self.msgView.backgroundColor = .black
        self.chatUserImg.layer.cornerRadius = self.chatUserImg.frame.width / 2
        self.chatUserImg.clipsToBounds = true
    }
    
   
}

class ChatRightCell : UITableViewCell{
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var msgLabl: UILabel!
    @IBOutlet weak var chatUserImg: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var msgsendImg : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        msgView.layer.cornerRadius = 5
        self.msgView.setCorneredElevation(shadow: 1, corner: 10, color: .gray)
//        self.msgLabl.textColor = .black
//        self.timeLbl.textColor = .darkGray
        self.msgView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        self.chatUserImg.layer.cornerRadius = self.chatUserImg.frame.width / 2
        self.chatUserImg.clipsToBounds = true
       
    }
    
    
    
}
class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.insetBy(dx: leftInset, dy: topInset))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}


