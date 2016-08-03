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

    static let HeaderElementKind = "StickyHeaderElement"

    var stickyHeaderReferenceSize = CGSize.zero {
        didSet {
            self.invalidateLayout()
        }
    }

    var stickyHeaderMinimumReferenceSize = CGSize.zero {
        didSet {
            self.invalidateLayout()
        }
    }

    var headerAlwaysOnTop = false {
        didSet {
            self.invalidateLayout()
        }
    }

    override init() {
        super.init()
        self.scrollDirection = .Vertical
        self.minimumInteritemSpacing = 1
        self.minimumLineSpacing = 1
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func initialLayoutAttributesForAppearingSupplementaryElementOfKind(elementKind: String, atIndexPath elementIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingSupplementaryElementOfKind(elementKind, atIndexPath: elementIndexPath)
        // Sticky Header?
        if elementKind == StickyCellCollectionViewLayout.HeaderElementKind {
            // Sticky header do not need to offset, it's the first element
            return nil
        }
        attributes?.frame.origin.y += self.stickyHeaderReferenceSize.height
        return attributes
    }

    override func finalLayoutAttributesForDisappearingSupplementaryElementOfKind(elementKind: String, atIndexPath elementIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.finalLayoutAttributesForDisappearingSupplementaryElementOfKind(elementKind, atIndexPath: elementIndexPath)
        // Sticky Header?
        if elementKind == StickyCellCollectionViewLayout.HeaderElementKind, let attributes = self.layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath: elementIndexPath) {
            return attributes //updateStickyHeaderAttributes
        }
        return attributes
    }

    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath: indexPath)
        if elementKind == StickyCellCollectionViewLayout.HeaderElementKind && attributes == nil {
            return UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)
        }
        return attributes
    }

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        attributes?.frame.origin.y += self.stickyHeaderReferenceSize.height
        return attributes
    }

    override func collectionViewContentSize() -> CGSize {
        if self.collectionView?.superview == nil {
            return CGSize.zero
        }
        var size = super.collectionViewContentSize()
        size.height += self.stickyHeaderReferenceSize.height
        return size
    }

    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else {
            return nil
        }
        if collectionView.dataSource == nil {
            return nil
        }

        var adjustedRect = rect
        adjustedRect.origin.y -= stickyHeaderReferenceSize.height

        // Call the super implementation with original rect (without the sticky header)
        guard let allOriginalAttributes = super.layoutAttributesForElementsInRect(adjustedRect) else {
            return nil
        }

        var allAttributes = [UICollectionViewLayoutAttributes]()
        var visibleParallaxHeader = false

        allOriginalAttributes.forEach { originalAttributes in
            let attributes = originalAttributes.copy() as! UICollectionViewLayoutAttributes

            switch attributes.representedElementKind {
            case .Some(UICollectionElementKindSectionHeader):
                // Not implemented
                break
            case .Some(UICollectionElementKindSectionFooter):
                // Not implemented
                break
            default:
                if attributes.indexPath.item == 0 && attributes.indexPath.section == 0 {
                    visibleParallaxHeader = true
                }
            }

            attributes.frame.origin.y += stickyHeaderReferenceSize.height
            // For iOS 7.0, the cell zIndex should be above sticky section header
            attributes.zIndex = 1
            allAttributes.append(attributes)
        }

        // When the visible rect is at top of the screen, make sure we see the Sticky header
        if rect.minY <= 0 {
            visibleParallaxHeader = true
        }

        // Create the attributes for the Sticky header
        if visibleParallaxHeader && CGSizeEqualToSize(CGSizeZero, self.stickyHeaderReferenceSize) == false {
            let currentAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: StickyCellCollectionViewLayout.HeaderElementKind, withIndexPath: NSIndexPath(index: 0))

            currentAttribute.frame.size = self.stickyHeaderReferenceSize

            // Make sure the frame won't be negative values
            var currentY = min(currentAttribute.frame.maxY - stickyHeaderMinimumReferenceSize.height, collectionView.bounds.origin.y + collectionView.contentInset.top)
            let currentHeight = max(0, -currentY + currentAttribute.frame.maxY)

            // If zIndex < 0 would prevents tap from recognized right under navigation bar
            currentAttribute.zIndex = 0 //Bring to front!

            // We will check when we should update the y position
            if self.headerAlwaysOnTop && currentHeight <= stickyHeaderMinimumReferenceSize.height {
                let insetTop = collectionView.contentInset.top
                // Always stick to top but under the nav bar
                currentY = collectionView.contentOffset.y + insetTop
                currentAttribute.zIndex = 2000
            }

            currentAttribute.frame = CGRect(
                x: currentAttribute.frame.origin.x,
                y: currentY,
                width: currentAttribute.frame.size.width,
                height: currentHeight
            )
            allAttributes.append(currentAttribute)
        }

        return allAttributes
    }

}

class TestViewController: UIViewController {

    let data = ["Ricardo Pereira", "khiguygiuyig", "98798yfjhfkh", "sdfg34tq34", "egsdfg3qerg", "hgjhguygu", "9as87df98ahsdf", "as897ydfy78sd", "asd7yfyfff", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "khiguygiuyig", "asdf888888888"
    ]

    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 600), collectionViewLayout: UICollectionViewFlowLayout())
    let layout = StickyCellCollectionViewLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .redColor()

        collectionView.registerClass(StickyCollectionViewCell.self, forCellWithReuseIdentifier: "StickyCollectionViewCell")

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .whiteColor()

        layout.itemSize = CGSizeMake(collectionView.frame.size.width, 44)

        // Sticky Header
        collectionView.registerClass(StickyHeaderView.self, forSupplementaryViewOfKind: StickyCellCollectionViewLayout.HeaderElementKind, withReuseIdentifier: "StickyHeader")
        layout.stickyHeaderReferenceSize = CGSize(width: collectionView.frame.size.width, height: 100)

        view.addSubview(collectionView)
    }

}

class StickyHeaderView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blueColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension TestViewController: UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StickyCollectionViewCell", forIndexPath: indexPath)
        if let cell = cell as? StickyCollectionViewCell {
            cell.title = data[indexPath.item]
        }
        return cell
    }


    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == StickyCellCollectionViewLayout.HeaderElementKind {
            return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "StickyHeader", forIndexPath: indexPath)
        }
        return UICollectionReusableView()
    }

}

extension TestViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? StickyCollectionViewCell else { return }
        cell.title = data[indexPath.item]
    }

}

XCPlaygroundPage.currentPage.liveView = TestViewController()
