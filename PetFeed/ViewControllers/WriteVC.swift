//
//  WriteVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 8..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit
import Pickle
import Photos

class WriteVC: UIViewController {
    
    var items: [PHAsset] = []
    
    var picker = ImagePickerController()
    
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        textView.delegate = self
        textView.text = "해시태그와 함께 사진, 동영상에 대해 설명해주세요. (250자)"
        textView.textColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        textView.font = UIFont(name: "NanumSquareRoundOTFRj", size: 12.0)
        textView.returnKeyType = .done
        
        var parameters = Pickle.Parameters()
        parameters.navigationBarBackgroundColor = UIColor.camoGreen
        parameters.navigationBarTintColor = UIColor.white
        parameters.navigationBarTitleTintColor = UIColor.white
        //parameters.allowedSelections = .limit(to: 1)
        
        picker = ImagePickerController(
            selectedAssets: items,
            configuration: parameters,
            cameraType: UIImagePickerController.self
        )
        picker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func confirmBtnPressed(_ sender: UIButton) {
        guard let text = textView.text,!text.isEmpty else {
            show_alert(with: "글을 입력해주세요.")
            return
        }
        
        API.Board.post(withToken: API.currentToken, content: text, pictures: items) { (json) in
            print(json["success"])
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension WriteVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            if cell.reuseIdentifier == "plusBtn" {
                present(picker, animated: true, completion: nil)
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //+1 as button
        return items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let btn = collectionView.dequeueReusableCell(withReuseIdentifier: "plusBtn", for: indexPath)
            btn.contentView.layer.cornerRadius = 4.0
            btn.contentView.layer.masksToBounds = true
            
            btn.layer.shadowColor = UIColor.gray.cgColor
            btn.layer.shadowOffset = CGSize(width: 4, height: 4)
            btn.layer.shadowRadius = 4.0
            btn.layer.shadowOpacity = 0.5
            btn.layer.masksToBounds = false
            btn.layer.shadowPath = UIBezierPath(roundedRect: btn.bounds, cornerRadius: btn.contentView.layer.cornerRadius).cgPath
            return btn
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageSelectCell
            //-1 because of btn
            cell.layer.cornerRadius = 4.0
            cell.layer.masksToBounds = true
            cell.imageView.image = getAssetThumbnail(asset: items[indexPath.row-1], size: cell.frame.width)
            
            
            
            return cell
            
        }
    }
    
    
}

extension WriteVC: ImagePickerControllerDelegate {
    func imagePickerController(_ picker: ImagePickerController, shouldLaunchCameraWithAuthorization status: AVAuthorizationStatus) -> Bool {
        return true
    }
    
    func imagePickerController(_ picker: ImagePickerController, didFinishPickingImageAssets assets: [PHAsset]) {
        items = assets
//        for i in assets {
//            print(i.pixelWidth,"and",i.pixelHeight)
//        }
        
        picker.dismiss(animated: true) {
            self.collectionView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: ImagePickerController) {
        picker.dismiss(animated: true, completion: nil)

    }
    
    func getAssetThumbnail(asset: PHAsset, size: CGFloat) -> UIImage {
        let retinaScale = UIScreen.main.scale
        let retinaSquare = CGSize(width: size * retinaScale, height: size * retinaScale)//(size * retinaScale, size * retinaScale)
        let cropSizeLength = min(asset.pixelWidth, asset.pixelHeight)
        let square = CGRect(x:0, y: 0,width: CGFloat(cropSizeLength),height: CGFloat(cropSizeLength))
        let cropRect = square.applying(CGAffineTransform(scaleX: 1.0/CGFloat(asset.pixelWidth), y: 1.0/CGFloat(asset.pixelHeight)))
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var thumbnail = UIImage()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        options.normalizedCropRect = cropRect
        manager.requestImage(for: asset, targetSize: retinaSquare, contentMode: .aspectFit, options: options, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
}

extension WriteVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "해시태그와 함께 사진, 동영상에 대해 설명해주세요. (250자)" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "해시태그와 함께 사진, 동영상에 대해 설명해주세요. (250자)"
            textView.textColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)        }
    }
}
