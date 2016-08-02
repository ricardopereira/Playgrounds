//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

class StickyCollectionViewCell: UICollectionViewCell {

    private let titleLabel = UILabel()
    var title: String = "" {
        didSet {
            if title.isEmpty {
                titleLabel.removeFromSuperview()
            }
            else if titleLabel.superview == nil {
                self.contentView.addSubview(titleLabel)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activateConstraints([
                    titleLabel.topAnchor.constraintEqualToAnchor(contentView.topAnchor),
                    titleLabel.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor),
                    titleLabel.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor),
                    titleLabel.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor),
                ])
                titleLabel.text = title
            }
            else {
                titleLabel.text = title
            }
        }
    }

}

class StickyCellCollectionViewLayout: UICollectionViewFlowLayout {

    private var currentIndex = 1

    override init() {
        super.init()
        self.scrollDirection = .Vertical
        self.minimumInteritemSpacing = 1
        self.minimumLineSpacing = 1
        self.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 40, right: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    func setActiveIndex(index: Int) {
        currentIndex = index
        invalidateLayout()
    }

    func setActiveAttributes(attributes: UICollectionViewLayoutAttributes) {
        guard let collectionView = collectionView else { return }
        let contentOffset = collectionView.contentOffset.y
        if attributes.frame.minY < contentOffset {
            // Attributes want to be above the visible rect, so let's stick it to the top.
            attributes.frame.origin.y = contentOffset
        }
        else if attributes.frame.maxY > collectionView.frame.height + contentOffset {
            // Attributes want to be below the visible rect, so let's stick it to the bottom (height + contentOffset - height of attributes)
            attributes.frame.origin.y = collectionView.frame.height + contentOffset - attributes.frame.height
        }
        attributes.zIndex = 1
    }

    override func prepareLayout() {
        super.prepareLayout()

        let width: CGFloat = 300
        let height: CGFloat = 40

        itemSize = CGSize(width: width, height: height)
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributesArray = super.layoutAttributesForElementsInRect(rect) else {
            return nil
        }
        var attributesArray = superAttributesArray.flatMap { $0 }

        // Guarantee any selected cell is presented, regardless of the rect.
        let items = attributesArray.map { $0.indexPath.item }
        if items.contains(currentIndex) == false {
            let indexPath = NSIndexPath(forItem: currentIndex, inSection: 0)
            // TODO: Don't like the crash operator here.
            attributesArray += [layoutAttributesForItemAtIndexPath(indexPath)!]
        }

        let filteredAttributesArray = attributesArray
            .filter { $0.indexPath.item == currentIndex }

        filteredAttributesArray.forEach(setActiveAttributes)

        return attributesArray
    }

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItemAtIndexPath(indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }

        if attributes.indexPath.item == currentIndex {
            setActiveAttributes(attributes)
        }
        
        return attributes
    }

    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }

}

class TestViewController: UIViewController {

    let data = ["hgjhguygu", "khiguygiuyig", "98798yfjhfkh", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig"
    ]

    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), collectionViewLayout: UICollectionViewFlowLayout())
    let layout = StickyCellCollectionViewLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .redColor()

        collectionView.registerClass(StickyCollectionViewCell.self, forCellWithReuseIdentifier: "StickyCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .whiteColor()

        view.addSubview(collectionView)
    }

}

extension TestViewController: UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StickyCollectionViewCell", forIndexPath: indexPath)
        // ?!
        if let cell = cell as? StickyCollectionViewCell {
            cell.title = data[indexPath.item]
        }
        if layout.currentIndex == indexPath.item {
            cell.backgroundColor = .blueColor()
        }
        return cell
    }

}

extension TestViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? StickyCollectionViewCell else { return }
        cell.title = data[indexPath.item]
    }

}

let testVC = TestViewController()

XCPlaygroundPage.currentPage.liveView = testVC
