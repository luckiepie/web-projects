class Calculator {
    constructor(previousOperandTextElement, currentOperandTextElement) {
        this.previousOperandTextElement = previousOperandTextElement
        this.currentOperandTextElement = currentOperandTextElement
        this.clear()
    }

    clear() {
        this.currentOperand = ''
        this.previousOperand = ''
        this.operation = undefined
    }

    delete() {
        this.currentOperand = this.currentOperand.toString().slice(0, -1)
    }

    appendNumber(number) {
        if(number === '.' && this.currentOperand.includes('.')) return  // '.'이 이미 1개 있다면, 아무것도 하지 않고 함수 실행을 즉시 종료(return)
        this.currentOperand = this.currentOperand.toString() + number.toString()    // .toString()처리 하지 않으면 수학적 덧셈이 됨. 문자열 + 문자열 -> 문자열 이어붙이기
    }

    chooseOperation(operation) {
        if(this.currentOperand === '')  return
        if(this.previousOperand !== '') {       // 이전에 입력한 숫자가 있다면, 계산한 결과를 previousOperand에다가 보여줌
            this.compute()
        }
        this.operation = operation
        this.previousOperand = this.currentOperand
        this.currentOperand = ''
    }

    compute() {
        let computation         // compute function의 결과값이 될 변수
        const prev = parseFloat(this.previousOperand)       // parseFloat() 는 숫자면 number, 숫자 아니면 NaN을 return.
        const current = parseFloat(this.currentOperand)
        if(isNaN(prev) || isNaN(current))   return          // 둘 중 하나라도 NaN이면 true -> return 실행 -> 아래 계산 코드 skip(조기 종료).
        switch(this.operation) {
            case '+' : 
                computation = prev + current
                break
            case '-' : 
                computation = prev - current
                break
            case '*' : 
                computation = prev * current
                break
            case '÷' : 
                computation = prev / current
                break
            default: 
                return
        }
        this.currentOperand = computation
        this.operation = undefined
        this.previousOperand = ''
    }

    getDisplayNumber(number) {  // 3나리씩 끊어서 ,로 표시
        const stringNumber = number.toString()
        const integerDigits = parseFloat(stringNumber.split('.')[0])    // split('.')[0] : 소수점(.) 앞에 있는 integer value
        const decimalDigits = stringNumber.split('.')[1]    // 소수점(.) 뒤의 value
        let integerDisplay

        if(isNaN(integerDigits)) {
            integerDisplay = ''
        } else {
            integerDisplay = integerDigits.toLocaleString('en', {maximumFractionDigits:0})
        }
        
        if(decimalDigits != null) {
            return `${integerDisplay}.${decimalDigits}`
        } else {
            return integerDisplay
        }


        /*
        const floatNumber = parseFloat(number)  // 전달받은 number가 실제로는 String이기 때문에 parseFloat()사용해서 number로 형변환
        if(isNaN(floatNumber))  return ''       // number가 아니면, 표시하지X
        return floatNumber.toLocaleString('en')
        */

    }

    updateDisplay() {
        this.currentOperandTextElement.innerText = this.getDisplayNumber(this.currentOperand)
        if(this.operation != null) {
            this.previousOperandTextElement.innerText = 
                `${this.getDisplayNumber(this.previousOperand)} ${this.operation}`
        } else {
            this.previousOperandTextElement.innerText = ''
        }
    }

}


const numberButtons = document.querySelectorAll('[data-number]')
const operationButtons = document.querySelectorAll('[data-operation]');
const equalsButton = document.querySelector('[data-equals]');
const deleteButton = document.querySelector('[data-delete]');
const allClearButton = document.querySelector('[data-all-clear]');
const previousOperandTextElement = document.querySelector('[data-previous-operand]');
const currentOperandTextElement = document.querySelector('[data-current-operand]');

const calculator = new Calculator(previousOperandTextElement, currentOperandTextElement)

numberButtons.forEach(button => {
    button.addEventListener('click', () => {        // button click하면 event 발생
        calculator.appendNumber(button.innerText)   // add number
        calculator.updateDisplay()                  
    })
})

operationButtons.forEach(button => {
    button.addEventListener('click', () => {        // button click하면 event 발생
        calculator.chooseOperation(button.innerText)   // add number
        calculator.updateDisplay()                  
    })
})

equalsButton.addEventListener('click', button => {
    calculator.compute()
    calculator.updateDisplay()
})

allClearButton.addEventListener('click', button => {
    calculator.clear()
    calculator.updateDisplay()
})

deleteButton.addEventListener('click', button => {
    calculator.delete()
    calculator.updateDisplay()
})