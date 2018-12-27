

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

print(bmiCalculator(weight: 215, heightInFeet: 5, heightInInches: 10))