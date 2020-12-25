/*
 ✏️문제
 수학의 미해결 문제 중 하나로 콜라츠 추측(Collatz Congecture)이 있습니다.
 
 콜라츠 추측
 자연수 n에 대해,
 - n이 짝수인 경우, n을 2로 나눈다.
 - n이 홀수인 경우, n에 3을 곱해 1을 더한다.
 위의 계산을 반복하면 초깃값이 어떤 수였더라도 반드시 1에 도달한다.
 
 이 내용을 조금 바꾸어 초깃값이 짝수면 맨 처음에만 n에 3을 곱하여 1을 더하는 것에서 시작하기로 하고, '맨 처음의 수'로 돌아가는 법을 생각해봅시다.
 
 예를 들어 2로 시작하는 경우에는 다음과 같습니다.
 2 -> 7 -> 22 -> 11 -> 34 -> 17 -> 52 -> 26 -> 13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2
 
 그러나 6으로 시작하면 다음과 같이 되어 6으로 되돌아가지 않습니다.
 6 -> 19 -> 58 -> 29 -> 88 -> 44 -> 22 -> 11 -> 34 -> 17 -> 52 -> 26 -> 13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1 -> 4 -> ...
 
 
 10,000 이하의 짝수 중 '처음으로 돌아가는 수'가 몇 개 있는지 구해보세요.
 */

import Foundation

//우선 콜라츠 추측을 구현해본다

func collatz(_ startNum: Int,_ numberNow: Int,_ count: Int) -> Int {
    if numberNow == 1 {
        return 0
    } else if numberNow % 2 == 0 {
        return 1 + collatz(startNum, numberNow / 2, count+1)
    } else {
        return 1 + collatz(startNum, numberNow * 3 + 1, count+1)
    }
}

let n = 10
print("\(n)는 콜라츠 추측에 따르면 계산 \(collatz(n, n, 0))번만에 1이 된다")



//재귀로 구현
func backToStartNum(_ startNum: Int,_ numberNow: Int,_ count: Int) -> Bool {
    if numberNow == startNum && count != 0 {
        return true
    } else if numberNow == 1 {
        return false
    } else if count == 0 || numberNow % 2 == 1{
        return backToStartNum(startNum, numberNow * 3 + 1, count+1)
    } else {
        return backToStartNum(startNum, numberNow / 2, count+1)
    }
}

var answer = 0
for number in 1...5000 {
    if backToStartNum(number*2, number*2, 0) { answer += 1 }
}
print("정답은 \(answer)개")


//반복문으로 구현
func backToStartNum2(startNum: Int) -> Bool {
    
    var numberNow = startNum * 3 + 1
    
    while numberNow != 1, numberNow != startNum {
        let remainder = numberNow % 2
        numberNow = remainder == 0 ? numberNow/2 : numberNow * 3 + 1
    }
    
    return numberNow == 1 ? false : true
}

var answer2 = 0
for number in 1...5000 {
    if backToStartNum2(startNum: number * 2) { answer2 += 1 }
}
print("정답은 \(answer2)개")
