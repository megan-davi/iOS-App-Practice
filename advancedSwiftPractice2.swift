import Foundation

// Prompt: how many buckets of paint do I need to cover a wall with paint?

// wall dimensions in square meters
var width: Float = 1.5
var height: Float = 2.3

var paintCoverage: Float = 1.5

var bucketsOfPaint: Int {
    // number of paint buckets needed based on wall size (rounded up)
    get {    // called when bucketsOfPaint is called
        let paintBuckets = Int(ceilf(width * height / paintCoverage))
        print("To cover a \(width) x \(height) wall, you need \(paintBuckets) buckets of paint.")
        return paintBuckets

    // area that could be covered with a new number of paint buckets when specified
    } set {  // called when bucketsOfPaint is changed
        let newArea = Double(newValue) * 1.5
        print("Buckets of paint changed from \(bucketsOfPaint) to \(newValue). \(newValue) buckets of paint can cover an area of \(newArea) square meters.")
    }
}

bucketsOfPaint = 8