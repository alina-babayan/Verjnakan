import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 1400
    height: 800
    title: "Lumi"

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: loginPage
    }

    /************ LOGIN PAGE ************/
    Component {
        id: loginPage
        Rectangle {
            color: "#f8f9fa"

            RowLayout {
                anchors.fill: parent
                spacing: 0

                // LEFT - Form
                Rectangle {
                    Layout.preferredWidth: 700
                    Layout.fillHeight: true
                    color: "white"

                    Column {
                        anchors.centerIn: parent
                        width: 440
                        spacing: 32

                        // LOGO
                        Rectangle {
                            width: 56; height: 56; radius: 12; color: "#1a1a1a"; anchors.horizontalCenter: parent.horizontalCenter
                            Text { text: "L"; color: "white"; font.pixelSize: 32; font.bold: true; anchors.centerIn: parent }
                        }

                        // TITLE
                        Column {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 8
                            Text {
                                text: "Login"
                                font.pixelSize: 32
                                font.bold: true
                                color: "#1a1a1a"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text {
                                text: "Login with your email and password to continue"
                                color: "#666"
                                font.pixelSize: 14
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        // FORM
                        Column {
                            width: parent.width
                            spacing: 20

                            // EMAIL FIELD WITH LABEL
                            Column {
                                width: parent.width
                                spacing: 8
                                Text {
                                    text: "Email"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#333"
                                }
                                TextField {
                                    id: emailField
                                    placeholderText: "Enter your email"
                                    font.pixelSize: 15
                                    width: parent.width
                                    height: 52
                                    leftPadding: 16
                                    rightPadding: 16
                                    background: Rectangle {
                                        radius: 8
                                        color: "#ffffff"
                                        border.color: emailField.activeFocus ? "#1a1a1a" : "#e5e7eb"
                                        border.width: 1
                                    }
                                }
                            }

                            // PASSWORD FIELD WITH LABEL AND SHOW/HIDE
                            Column {
                                width: parent.width
                                spacing: 8
                                property bool passwordHidden: true

                                Text {
                                    text: "Password"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#333"
                                }

                                Rectangle {
                                    width: parent.width
                                    height: 52
                                    radius: 8
                                    color: "#ffffff"
                                    border.color: passwordField.activeFocus ? "#1a1a1a" : "#e5e7eb"
                                    border.width: 1

                                    Row {
                                        anchors.fill: parent
                                        anchors.leftMargin: 16
                                        anchors.rightMargin: 12
                                        spacing: 8

                                        TextField {
                                            id: passwordField
                                            placeholderText: "Enter your password"
                                            font.pixelSize: 15
                                            echoMode: parent.parent.parent.passwordHidden ? TextInput.Password : TextInput.Normal
                                            width: parent.width - 44
                                            anchors.verticalCenter: parent.verticalCenter
                                            background: Rectangle { color: "transparent" }
                                            leftPadding: 0
                                            rightPadding: 0
                                        }

                                        Rectangle {
                                            width: 32
                                            height: 32
                                            radius: 6
                                            color: mouseArea.containsMouse ? "#f3f4f6" : "transparent"
                                            anchors.verticalCenter: parent.verticalCenter

                                            Canvas {
                                                anchors.centerIn: parent
                                                width: 20
                                                height: 20
                                                onPaint: {
                                                    var ctx = getContext("2d")
                                                    ctx.clearRect(0, 0, width, height)
                                                    ctx.strokeStyle = parent.parent.parent.parent.passwordHidden ? "#6b7280" : "#1a1a1a"
                                                    ctx.lineWidth = 1.5

                                                    if (parent.parent.parent.parent.passwordHidden) {
                                                        // Eye closed - line with slash
                                                        ctx.beginPath()
                                                        ctx.moveTo(2, 10)
                                                        ctx.quadraticCurveTo(10, 13, 18, 10)
                                                        ctx.stroke()

                                                        // Slash
                                                        ctx.beginPath()
                                                        ctx.moveTo(4, 16)
                                                        ctx.lineTo(16, 4)
                                                        ctx.stroke()
                                                    } else {
                                                        // Eye open
                                                        ctx.beginPath()
                                                        ctx.moveTo(2, 10)
                                                        ctx.quadraticCurveTo(10, 4, 18, 10)
                                                        ctx.quadraticCurveTo(10, 16, 2, 10)
                                                        ctx.stroke()

                                                        // Pupil
                                                        ctx.beginPath()
                                                        ctx.arc(10, 10, 3, 0, 2 * Math.PI)
                                                        ctx.fillStyle = ctx.strokeStyle
                                                        ctx.fill()
                                                    }
                                                }

                                                Connections {
                                                    target: parent.parent.parent.parent
                                                    function onPasswordHiddenChanged() {
                                                        parent.requestPaint()
                                                    }
                                                }
                                            }

                                            MouseArea {
                                                id: mouseArea
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                hoverEnabled: true
                                                onClicked: parent.parent.parent.parent.passwordHidden = !parent.parent.parent.parent.passwordHidden
                                            }
                                        }
                                    }
                                }
                            }

                            // REMEMBER ME & FORGOT PASSWORD
                            RowLayout {
                                width: parent.width
                                spacing: 0
                                CheckBox {
                                    id: rememberMe
                                    text: "Remember Me"
                                    font.pixelSize: 14
                                }
                                Item { Layout.fillWidth: true }
                                Text {
                                    text: "Forgot Password?"
                                    color: "#3b82f6"
                                    font.pixelSize: 14
                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: stack.push(forgotPasswordPage)
                                    }
                                }
                            }

                            // LOGIN BUTTON
                            Button {
                                text: "Login"
                                width: parent.width
                                height: 52
                                background: Rectangle {
                                    radius: 8
                                    color: parent.pressed ? "#0f0f0f" : (parent.hovered ? "#2a2a2a" : "#1a1a1a")
                                }
                                contentItem: Text {
                                    text: parent.text
                                    color: "white"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onClicked: {
                                    let masked = emailField.text.replace(/(.).*(?=@)/, "$1***")
                                    stack.push(otpPage, { maskedEmail: masked })
                                }
                            }

                            // REGISTER LINK
                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 4
                                Text {
                                    text: "Don't have an account?"
                                    color: "#6b7280"
                                    font.pixelSize: 14
                                }
                                Text {
                                    text: "Register as an instructor"
                                    color: "#3b82f6"
                                    font.pixelSize: 14
                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: console.log("Register clicked")
                                    }
                                }
                            }
                        }
                    }
                }

                // RIGHT - Illustration
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#f8f9fa"

                    Image {
                        source: "qrc:new/prefix1/first"
                        anchors.centerIn: parent
                        width: parent.width * 0.999
                        height: parent.height * 1.35
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }
    }

    /************ OTP PAGE ************/
    Component {
        id: otpPage
        Rectangle {
            color: "#f8f9fa"
            property string maskedEmail: ""
            property int resendSeconds: 60
            property var otpInputs: []

            RowLayout {
                anchors.fill: parent
                spacing: 0

                // LEFT - OTP FORM
                Rectangle {
                    Layout.preferredWidth: 700
                    Layout.fillHeight: true
                    color: "white"

                    Column {
                        anchors.centerIn: parent
                        width: 440
                        spacing: 32

                        Rectangle {
                            width: 56; height: 56; radius: 12
                            color: "#1a1a1a"
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text {
                                text: "L"
                                color: "white"
                                font.pixelSize: 32
                                font.bold: true
                                anchors.centerIn: parent
                            }
                        }

                        Column {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 8
                            Text {
                                text: "Verify Your Login"
                                font.pixelSize: 32
                                font.bold: true
                                color: "#1a1a1a"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Text {
                                text: "Enter the OTP(one time password) to verify your login.
     A code has been sent to " + maskedEmail
                                color: "#6b7280"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        Row {
                            spacing: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                            Repeater {
                                model: 6
                                Rectangle {
                                    width: 60
                                    height: 64
                                    radius: 8
                                    color: "#ffffff"
                                    border.color: otpBox.activeFocus ? "#1a1a1a" : "#e5e7eb"
                                    border.width: otpBox.activeFocus ? 2 : 1

                                    TextInput {
                                        id: otpBox
                                        anchors.centerIn: parent
                                        font.pixelSize: 28
                                        font.bold: true
                                        maximumLength: 1
                                        horizontalAlignment: TextInput.AlignHCenter
                                        verticalAlignment: TextInput.AlignVCenter
                                        color: "#1a1a1a"

                                        Component.onCompleted: otpInputs.push(otpBox)
                                        focus: index === 0

                                        onTextChanged: {
                                            if (text.length === 1) {
                                                let next = otpInputs[index + 1]
                                                if (next) next.forceActiveFocus()
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Button {
                            text: "Verify"
                            width: parent.width
                            height: 52
                            background: Rectangle {
                                radius: 8
                                color: parent.pressed ? "#0f0f0f" : (parent.hovered ? "#2a2a2a" : "#1a1a1a")
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                font.pixelSize: 16
                                font.weight: Font.Medium
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            onClicked: {
                                let code = otpInputs.map(b => b.text).join("")
                                console.log("OTP:", code)
                                stack.push(successPage)
                            }
                        }

                        Text {
                            id: resendText
                            text: "Resend code"
                            color: "#3b82f6"
                            font.pixelSize: 14
                            anchors.horizontalCenter: parent.horizontalCenter

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    resendSeconds = 60
                                    resendTimer.start()
                                }
                            }
                        }

                        Text {
                            text: "← Back to login"
                            color: "#3b82f6"
                            font.pixelSize: 14
                            anchors.horizontalCenter: parent.horizontalCenter

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: stack.pop()
                            }
                        }

                        Timer {
                            id: resendTimer
                            interval: 1000
                            repeat: true
                            running: false
                            onTriggered: {
                                resendSeconds--
                                if (resendSeconds <= 0) {
                                    resendTimer.stop()
                                    resendText.text = "Resend code"
                                } else {
                                    resendText.text = "Resend code (" + resendSeconds + "s)"
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#f8f9fa"

                    Image {
                        source: "qrc:new/prefix1/first"
                        anchors.centerIn: parent
                        width: parent.width * 0.999
                        height: parent.height * 1.35
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }

            Component.onCompleted: {
                if (otpInputs.length > 0)
                    otpInputs[0].forceActiveFocus()
            }
        }
    }

    /************ FORGOT PASSWORD PAGE ************/
    Component {
        id: forgotPasswordPage
        Rectangle {
            color: "#f8f9fa"

            RowLayout {
                anchors.fill: parent
                spacing: 0

                // LEFT - FORM
                Rectangle {
                    Layout.preferredWidth: 700
                    Layout.fillHeight: true
                    color: "white"

                    Column {
                        anchors.centerIn: parent
                        width: 440
                        spacing: 32

                        Rectangle {
                            width: 56; height: 56; radius: 12; color: "#1a1a1a"; anchors.horizontalCenter: parent.horizontalCenter
                            Text { text: "L"; color: "white"; font.pixelSize: 32; font.bold: true; anchors.centerIn: parent }
                        }

                        Column {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 8
                            Text {
                                text: "Forgot Password"
                                font.pixelSize: 32
                                font.bold: true
                                color: "#1a1a1a"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Text {
                                text: "Enter your email address to reset your password"
                                color: "#6b7280"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        Column {
                            width: parent.width
                            spacing: 20

                            Column {
                                width: parent.width
                                spacing: 8
                                Text {
                                    text: "Email"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#333"
                                }
                                TextField {
                                    id: forgotEmailField
                                    placeholderText: "Enter your email"
                                    font.pixelSize: 15
                                    width: parent.width
                                    height: 52
                                    leftPadding: 16
                                    rightPadding: 16
                                    background: Rectangle {
                                        radius: 8
                                        color: "#ffffff"
                                        border.color: forgotEmailField.activeFocus ? "#1a1a1a" : "#e5e7eb"
                                        border.width: 1
                                    }
                                }
                            }

                            Button {
                                text: "Send Reset Link"
                                width: parent.width
                                height: 52
                                background: Rectangle {
                                    radius: 8
                                    color: parent.pressed ? "#0f0f0f" : (parent.hovered ? "#2a2a2a" : "#1a1a1a")
                                }
                                contentItem: Text {
                                    text: parent.text
                                    color: "white"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onClicked: console.log("Reset link sent to:", forgotEmailField.text)
                            }

                            Text {
                                text: "← Back to login"
                                color: "#3b82f6"
                                font.pixelSize: 14
                                anchors.horizontalCenter: parent.horizontalCenter

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: stack.pop()
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#f8f9fa"

                    Image {
                        source: "qrc:new/prefix1/first"
                        anchors.centerIn: parent
                        width: parent.width * 0.999
                        height: parent.height * 1.35
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }
    }

    /************ RESET PASSWORD PAGE ************/
    Component {
        id: resetPasswordPage
        Rectangle {
            color: "#f8f9fa"

            RowLayout {
                anchors.fill: parent
                spacing: 0

                // LEFT - FORM
                Rectangle {
                    Layout.preferredWidth: 700
                    Layout.fillHeight: true
                    color: "white"

                    Column {
                        anchors.centerIn: parent
                        width: 440
                        spacing: 32

                        Rectangle {
                            width: 56; height: 56; radius: 12; color: "#1a1a1a"; anchors.horizontalCenter: parent.horizontalCenter
                            Text { text: "L"; color: "white"; font.pixelSize: 32; font.bold: true; anchors.centerIn: parent }
                        }

                        Column {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 8
                            Text {
                                text: "Set New Password"
                                font.pixelSize: 32
                                font.bold: true
                                color: "#1a1a1a"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Text {
                                text: "Your new password must be different from\npreviously used passwords"
                                color: "#6b7280"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                wrapMode: Text.WordWrap
                            }
                        }

                        Column {
                            width: parent.width
                            spacing: 20

                            // NEW PASSWORD
                            Column {
                                width: parent.width
                                spacing: 8
                                property bool passwordHidden: true

                                Text {
                                    text: "New Password"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#333"
                                }

                                Rectangle {
                                    width: parent.width
                                    height: 52
                                    radius: 8
                                    color: "#ffffff"
                                    border.color: newPasswordField.activeFocus ? "#1a1a1a" : "#e5e7eb"
                                    border.width: 1

                                    Row {
                                        anchors.fill: parent
                                        anchors.leftMargin: 16
                                        anchors.rightMargin: 12
                                        spacing: 8

                                        TextField {
                                            id: newPasswordField
                                            placeholderText: "Enter new password"
                                            font.pixelSize: 15
                                            echoMode: parent.parent.parent.passwordHidden ? TextInput.Password : TextInput.Normal
                                            width: parent.width - 44
                                            anchors.verticalCenter: parent.verticalCenter
                                            background: Rectangle { color: "transparent" }
                                            leftPadding: 0
                                            rightPadding: 0
                                        }

                                        Rectangle {
                                            width: 32
                                            height: 32
                                            radius: 6
                                            color: mouseArea1.containsMouse ? "#f3f4f6" : "transparent"
                                            anchors.verticalCenter: parent.verticalCenter

                                            Canvas {
                                                anchors.centerIn: parent
                                                width: 20
                                                height: 20
                                                onPaint: {
                                                    var ctx = getContext("2d")
                                                    ctx.clearRect(0, 0, width, height)
                                                    ctx.strokeStyle = parent.parent.parent.parent.passwordHidden ? "#6b7280" : "#1a1a1a"
                                                    ctx.lineWidth = 1.5

                                                    if (parent.parent.parent.parent.passwordHidden) {
                                                        ctx.beginPath()
                                                        ctx.moveTo(2, 10)
                                                        ctx.quadraticCurveTo(10, 13, 18, 10)
                                                        ctx.stroke()
                                                        ctx.beginPath()
                                                        ctx.moveTo(4, 16)
                                                        ctx.lineTo(16, 4)
                                                        ctx.stroke()
                                                    } else {
                                                        ctx.beginPath()
                                                        ctx.moveTo(2, 10)
                                                        ctx.quadraticCurveTo(10, 4, 18, 10)
                                                        ctx.quadraticCurveTo(10, 16, 2, 10)
                                                        ctx.stroke()
                                                        ctx.beginPath()
                                                        ctx.arc(10, 10, 3, 0, 2 * Math.PI)
                                                        ctx.fillStyle = ctx.strokeStyle
                                                        ctx.fill()
                                                    }
                                                }

                                                Connections {
                                                    target: parent.parent.parent.parent
                                                    function onPasswordHiddenChanged() {
                                                        parent.requestPaint()
                                                    }
                                                }
                                            }

                                            MouseArea {
                                                id: mouseArea1
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                hoverEnabled: true
                                                onClicked: parent.parent.parent.parent.passwordHidden = !parent.parent.parent.parent.passwordHidden
                                            }
                                        }
                                    }
                                }
                            }

                            // CONFIRM PASSWORD
                            Column {
                                width: parent.width
                                spacing: 8
                                property bool passwordHidden: true

                                Text {
                                    text: "Confirm Password"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#333"
                                }

                                Rectangle {
                                    width: parent.width
                                    height: 52
                                    radius: 8
                                    color: "#ffffff"
                                    border.color: confirmPasswordField.activeFocus ? "#1a1a1a" : "#e5e7eb"
                                    border.width: 1

                                    Row {
                                        anchors.fill: parent
                                        anchors.leftMargin: 16
                                        anchors.rightMargin: 12
                                        spacing: 8

                                        TextField {
                                            id: confirmPasswordField
                                            placeholderText: "Re-enter new password"
                                            font.pixelSize: 15
                                            echoMode: parent.parent.parent.passwordHidden ? TextInput.Password : TextInput.Normal
                                            width: parent.width - 44
                                            anchors.verticalCenter: parent.verticalCenter
                                            background: Rectangle { color: "transparent" }
                                            leftPadding: 0
                                            rightPadding: 0
                                        }

                                        Rectangle {
                                            width: 32
                                            height: 32
                                            radius: 6
                                            color: mouseArea2.containsMouse ? "#f3f4f6" : "transparent"
                                            anchors.verticalCenter: parent.verticalCenter

                                            Canvas {
                                                anchors.centerIn: parent
                                                width: 20
                                                height: 20
                                                onPaint: {
                                                    var ctx = getContext("2d")
                                                    ctx.clearRect(0, 0, width, height)
                                                    ctx.strokeStyle = parent.parent.parent.parent.passwordHidden ? "#6b7280" : "#1a1a1a"
                                                    ctx.lineWidth = 1.5

                                                    if (parent.parent.parent.parent.passwordHidden) {
                                                        ctx.beginPath()
                                                        ctx.moveTo(2, 10)
                                                        ctx.quadraticCurveTo(10, 13, 18, 10)
                                                        ctx.stroke()
                                                        ctx.beginPath()
                                                        ctx.moveTo(4, 16)
                                                        ctx.lineTo(16, 4)
                                                        ctx.stroke()
                                                    } else {
                                                        ctx.beginPath()
                                                        ctx.moveTo(2, 10)
                                                        ctx.quadraticCurveTo(10, 4, 18, 10)
                                                        ctx.quadraticCurveTo(10, 16, 2, 10)
                                                        ctx.stroke()
                                                        ctx.beginPath()
                                                        ctx.arc(10, 10, 3, 0, 2 * Math.PI)
                                                        ctx.fillStyle = ctx.strokeStyle
                                                        ctx.fill()
                                                    }
                                                }

                                                Connections {
                                                    target: parent.parent.parent.parent
                                                    function onPasswordHiddenChanged() {
                                                        parent.requestPaint()
                                                    }
                                                }
                                            }

                                            MouseArea {
                                                id: mouseArea2
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                hoverEnabled: true
                                                onClicked: parent.parent.parent.parent.passwordHidden = !parent.parent.parent.parent.passwordHidden
                                            }
                                        }
                                    }
                                }
                            }

                            // PASSWORD REQUIREMENTS
                            Column {
                                width: parent.width
                                spacing: 8

                                Text {
                                    text: "Password must contain:"
                                    font.pixelSize: 13
                                    color: "#6b7280"
                                    font.weight: Font.Medium
                                }

                                Column {
                                    width: parent.width
                                    spacing: 6

                                    Row {
                                        spacing: 8
                                        Rectangle {
                                            width: 16; height: 16; radius: 8
                                            color: "#e5e7eb"
                                            anchors.verticalCenter: parent.verticalCenter
                                            Text { text: "✓"; color: "#6b7280"; font.pixelSize: 10; anchors.centerIn: parent }
                                        }
                                        Text { text: "At least 8 characters"; font.pixelSize: 13; color: "#6b7280" }
                                    }

                                    Row {
                                        spacing: 8
                                        Rectangle {
                                            width: 16; height: 16; radius: 8
                                            color: "#e5e7eb"
                                            anchors.verticalCenter: parent.verticalCenter
                                            Text { text: "✓"; color: "#6b7280"; font.pixelSize: 10; anchors.centerIn: parent }
                                        }
                                        Text { text: "At least one uppercase letter"; font.pixelSize: 13; color: "#6b7280" }
                                    }

                                    Row {
                                        spacing: 8
                                        Rectangle {
                                            width: 16; height: 16; radius: 8
                                            color: "#e5e7eb"
                                            anchors.verticalCenter: parent.verticalCenter
                                            Text { text: "✓"; color: "#6b7280"; font.pixelSize: 10; anchors.centerIn: parent }
                                        }
                                        Text { text: "At least one lowercase letter"; font.pixelSize: 13; color: "#6b7280" }
                                    }

                                    Row {
                                        spacing: 8
                                        Rectangle {
                                            width: 16; height: 16; radius: 8
                                            color: "#e5e7eb"
                                            anchors.verticalCenter: parent.verticalCenter
                                            Text { text: "✓"; color: "#6b7280"; font.pixelSize: 10; anchors.centerIn: parent }
                                        }
                                        Text { text: "At least one number"; font.pixelSize: 13; color: "#6b7280" }
                                    }

                                    Row {
                                        spacing: 8
                                        Rectangle {
                                            width: 16; height: 16; radius: 8
                                            color: "#e5e7eb"
                                            anchors.verticalCenter: parent.verticalCenter
                                            Text { text: "✓"; color: "#6b7280"; font.pixelSize: 10; anchors.centerIn: parent }
                                        }
                                        Text { text: "At least one special character"; font.pixelSize: 13; color: "#6b7280" }
                                    }
                                }
                            }

                            Button {
                                text: "Reset Password"
                                width: parent.width
                                height: 52
                                background: Rectangle {
                                    radius: 8
                                    color: parent.pressed ? "#0f0f0f" : (parent.hovered ? "#2a2a2a" : "#1a1a1a")
                                }
                                contentItem: Text {
                                    text: parent.text
                                    color: "white"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onClicked: {
                                    if (newPasswordField.text === confirmPasswordField.text) {
                                        stack.push(successPage)
                                    } else {
                                        console.log("Passwords don't match")
                                    }
                                }
                            }

                            Text {
                                text: "← Back to login"
                                color: "#3b82f6"
                                font.pixelSize: 14
                                anchors.horizontalCenter: parent.horizontalCenter

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: stack.pop()
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#f8f9fa"
                    Image {
                        source: "qrc:new/prefix1/first"
                        anchors.centerIn: parent
                        width: parent.width * 0.999
                        height: parent.height * 1.35
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }
    }

    /************ SUCCESS PAGE ************/
    Component {
        id: successPage
        Rectangle {
            color: "#f8f9fa"
            anchors.fill: parent

            Column {
                anchors.centerIn: parent
                spacing: 16

                Rectangle {
                    width: 80
                    height: 80
                    radius: 40
                    color: "#10b981"
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        text: "✓"
                        color: "white"
                        font.pixelSize: 48
                        font.bold: true
                        anchors.centerIn: parent
                    }
                }

                Text {
                    text: "Login Successful!"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 32
                    color: "#1a1a1a"
                    font.bold: true
                }

                Text {
                    text: "Welcome back to Lumin"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 16
                    color: "#6b7280"
                }
            }
        }
    }
}
