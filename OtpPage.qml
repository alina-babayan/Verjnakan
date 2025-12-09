import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    color: "white"
    property string maskedEmail: ""
    property alias stack: stackRef

    property int resendSeconds: 60
    property var otpInputs: []

    signal verified(string code)

    Column {
        anchors.centerIn: parent
        width: 460
        spacing: 40

        // Illustration
        Image {
            source: "qrc:new/prefix1/first"
            width: 300
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Column {
            spacing: 16
            width: parent.width

            Text {
                text: "Verify Your Login"
                font.pixelSize: 28
                font.bold: true
                color: "#1a1a1a"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "We sent a 6-digit code to\n" + maskedEmail
                color: "#555"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // 6 OTP boxes
            Row {
                id: otpRow
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 12
            }

            Repeater {
                model: 6
                delegate: Rectangle {
                    width: 56; height: 64
                    radius: 12
                    color: "#f8f9fa"
                    border.color: "#ddd"
                    border.width: 2

                    TextInput {
                        id: otpBox
                        anchors.centerIn: parent
                        font.pixelSize: 28
                        font.bold: true
                        maximumLength: 1
                        horizontalAlignment: TextInput.AlignHCenter
                        verticalAlignment: TextInput.AlignVCenter

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

            Button {
                text: "Verify"
                width: parent.width
                height: 56
                background: Rectangle { radius: 12; color: "#1a1a1a" }
                contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }

                onClicked: {
                    let enteredCode = otpInputs.map(box => box.text).join("")
                    console.log("Entered OTP:", enteredCode)
                    // TODO: Verify with backend
                    if(stack) stack.push(successPage) // Success page
                }
            }

            Text {
                id: resendText
                text: "Resend code"
                color: "#0066cc"
                font.underline: true
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent
                    enabled: true
                    onClicked: {
                        resendSeconds = 60
                        resendTimer.start()
                        console.log("Resend code triggered")
                        // TODO: Call backend to resend code
                    }
                }
            }

            Timer {
                id: resendTimer
                interval: 1000
                repeat: true
                running: false
                onTriggered: {
                    resendSeconds -= 1
                    if(resendSeconds <= 0) {
                        resendTimer.stop()
                        resendText.enabled = true
                        resendText.text = "Resend code"
                    } else {
                        resendText.text = "Resend code (" + resendSeconds + "s)"
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if(otpInputs.length > 0) otpInputs[0].forceActiveFocus()
    }
}
