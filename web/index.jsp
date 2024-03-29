<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Java后端WebSocket的Tomcat实现</title>

    <script type="text/javascript">
        var webSocket = null;
        //判断当前浏览器是否支持WebSocket，若支持则建立连接
        if ('WebSocket' in window) {
            webSocket = new WebSocket("ws://localhost:8080/ws/mySocket");
        } else {
            alert('当前浏览器 Not support web socket')
        }

        //连接发生错误的回调方法
        webSocket.onerror = function () {
            setMessageInnerHTML("WebSocket连接发生错误");
        };

        //连接成功建立的回调方法
        webSocket.onopen = function () {
            setMessageInnerHTML("WebSocket连接成功");
        }

        //接收到消息的回调方法
        webSocket.onmessage = function (event) {
            setMessageInnerHTML(event.data);
        }

        //连接关闭的回调方法
        webSocket.onclose = function () {
            setMessageInnerHTML("WebSocket连接关闭");
        }

        //监听窗口关闭事件，当窗口关闭时，主动去关闭web socket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function () {
            closeWebSocket();
        }

        function setMessageInnerHTML(innerHTML) {
            document.getElementById('message').innerHTML += innerHTML + '<br/>';
        }

        function closeWebSocket() {
            webSocket.close();
        }

        function send() {
            var message = document.getElementById('text').value;
            webSocket.send(message);
        }
    </script>
</head>
<body>
<input id="text" type="text"/>
<button onclick="send()">发送消息</button>
<hr/>
<button onclick="closeWebSocket()">关闭连接</button>
<hr/>
<div id="message"></div>
</body>
</html>