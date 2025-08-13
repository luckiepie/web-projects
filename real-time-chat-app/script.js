// socket.io client 연결
const socket = io('http://localhost:3000')

// DOM 요소
const messageContainer = document.getElementById('message-container')
const messageForm = document.getElementById('send-container')
const messageInput = document.getElementById('message-input')

const name = prompt('What is your name?')   // 팝업 창에 user name 입력
appendMessage('You joined', 'receiver')
socket.emit('new-user', name)

socket.on('chat-message', data => {
    // 상대방 메시지: receiver 클래스 적용 (왼쪽에 배치)
    appendMessage(`${data.name}: ${data.message}`, 'receiver')  
})

socket.on('user-connected', name => {
    appendMessage(`${name} connected`, 'receiver')
})

socket.on('user-disconnected', name => {
    appendMessage(`${name} disconnected`, 'receiver')
})

// 메시지를 전송하더라도 페이지 새로고침 없이 실시간으로 메시지가 갱신되도록.
messageForm.addEventListener('submit', e => {
    e.preventDefault()  // 기본 동작을 방지하는 함수.
    const message = messageInput.value

    // 본인 메시지: sender 클래스 적용 (오른쪽에 배치)
    appendMessage(`You: ${message}`, 'sender')

    // 서버로 메시지 전송
    socket.emit('send-chat-message', message)
    messageInput.value = ''     // 입력창 초기화
})

// 메시지를 화면에 추가하는 함수 (sender 또는 receiver 클래스 적용)
function appendMessage(message, senderOrReceiver = 'receiver') {
    const messageElement = document.createElement('div')
    messageElement.classList.add('message', senderOrReceiver); // sender 또는 receiver 클래스를 적용
    messageElement.innerText = message
    messageContainer.append(messageElement)

    // 스크롤을 제일 아래로 이동
    messageContainer.scrollTop = messageContainer.scrollHeight
}
