

func bmiCalculator (weight: Float, heightInFeet: Float, heightInInches: Float) -> String {
    let totalHeight = heightInInches + (heightInFeet * 12)
    let bmi = (weight / (totalHeight * totalHeight)) * 705

    if bmi > 25 {
        return "Your BMI is \(bmi). You are overweight."
    } else if bmi > 18.5 && bmi <= 25 {
        return "Your BMI is \(bmi). You are a normal weight."
    } else {
        return "Your BMI is \(bmi). You are underweight."
    }
}

///////////////////////////////////////////////////////////////

func beerBottles() -> String {
    var lyrics: String = ""

    for i in (1 ... 99).reversed() {
        let newLine = "\n\(i) bottles of beer on the wall, \(i) bottles of beer. \nTake one down, pass it around, \(i - 1) bottles of beer on the wall.\n" 
        lyrics += newLine
    }
    lyrics += "\nNo more bottles of beer on the wall, no more bottles of beer. \nGo the the store and buy some more, 99 bottles of beer on the wall.\n"

    return lyrics
}

///////////////////////////////////////////////////////////////

func fibonacciNumbers(n: Int) -> Int {    // where n is the number of elements
    if n == 0 || n == 1 {
        return n }
    else {
        return fibonacciNumbers(n: n - 1) + fibonacciNumbers(n: n - 2) }
}

///////////////////////////////////////////////////////////////

// Uncomment below to run functions

// print(bmiCalculator(weight: 215, heightInFeet: 5, heightInInches: 10))


// print(beerBottles())


// for eachLoop in 0 ... 20 {
//     let result = fibonacciNumbers(n: eachLoop)
//     print(result)
// }