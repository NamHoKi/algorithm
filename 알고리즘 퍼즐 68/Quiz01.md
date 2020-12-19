## 	QUIZ 1 - 앞뒤가 같은 10진수 만들기

>  10진수, 2진수, 8진수 그 어느 것으로 표현하여도 대칭수가 되는 수 중, 10진수의 10 이상에서의 최솟값을 구해보세요.

787, 11011 등 대칭이 되는 수 중 최솟값을 구하면 되는 문제.

<br>

~~함수 이름들이 좀 구리긴 한데...~~

n진수 공통으로 사용할 수 있는 `checkDaeChing`을 통해 해당 숫자가 10진수/8진수/2진수에서 대칭인지를 확인하고, 모두 대칭일 경우에만 `check`의 반환값으로 true를 리턴한다.

```swift
func check(for number: Int) -> Bool {
    func checkDaeChing(for number: Int, _ jinsoo: Int) -> Bool {
        (...)
    }

    if checkDaeChing(for: number, 10),
       checkDaeChing(for: number, 8),
       checkDaeChing(for: number, 2) {
        return true
    } else { return false }
}
```

<br>

`checkDaeChing`의 내용으로는 다음의 2가지가 올 수 있다.<br>

### 1️⃣ 몫, 나머지를 활용하여 2진수와 8진수 산출

먼저, n진수의 n으로 나눈 나머지를 이용하여 전환하는 방법.<br>

각 자리수를 `A`에 저장하고, 맨 처음/맨끝 -> 맨 처음+1/맨끝 -1 ... 이 같은 수인지를 확인하고 같지 않을 경우 false, 모두 같을 경우 true를 리턴한다.

```swift
    func checkDaeChing(for number: Int, _ jinsoo: Int) -> Bool {
        var N = number
        var A: [Int] = []

        while N != 0 {
            A.insert(N % jinsoo, at: 0)
            N = N / jinsoo
        }

        let C = A.count-1
        for i in 0...C {
            if A[i] != A[C-i] { return false }
        }
        return true
    }
```

<br>

### 2️⃣ radix 활용하여 2진수와 8진수 산출

위의 방법으로 풀고 나서 책을 확인해보니 예시로 든 다른 언어들엔 기본 변환 함수가 있어 swift엔 없는지 확인해보았다.<br>

다음의 방법으로 n진수 String 변환이 가능하다.

```swift
let binaryNumber = String(10, radix: 2)
```

<br>

따라서 아래와 같이 작성하면 위와 같은 결과를 얻을 수 있다.

```swift
    func checkDaeChing(for number: Int, _ jinsoo: Int) -> Bool {
        let newN = String(number, radix: jinsoo)
        let newNArray = newN.map{ String($0) }
        let C = newN.count-1

        for i in 0...C {
            if newNArray[i] != newNArray[C-i] { return false }
        }
        return true
    }
```

<br>

그리고 위에서 작성한 함수를 활용하여 최솟값을 산출하면 된다.<br>

10이상이므로 9로 시작하고, 2진수에서는 홀수만 대칭일 수 있기 때문에 루프가 반복될 때마다 2를 더하여 홀수만 체크하도록 했다.<br>

(짝수일 경우 가장 오른쪽 자리가 0이 되고, 가장 왼쪽 자리엔 0이 오지 않으므로 홀수만 가능)<br>

```swift
var n = 9
var result = false

while result == false {
    n += 2
    result = check(for: n)
}

print(n) //585
```

정답은 585! 👏🏻👏🏻👏🏻