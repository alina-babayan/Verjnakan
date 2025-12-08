import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    color: "white"
    property string maskedEmail: ""

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
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 12
                Repeater {
                    model: 6
                    Rectangle {
                        width: 56; height: 64
                        radius: 12
                        color: "#f8f9fa"
                        border.color: "#ddd"
                        border.width: 2

                        TextInput {
                            anchors.centerIn: parent
                            font.pixelSize: 28
                            font.bold: true
                            maximumLength: 1
                            horizontalAlignment: TextInput.AlignHCenter
                            verticalAlignment: TextInput.AlignVCenter
                            focus: index === 0
                            onTextChanged: if (text.length === 1 && index < 5) parent.parent.children[index+1].forceActiveFocus()
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

                onClicked: stack.push(successPage)
            }

            Text {
                text: "Resend code"
                color: "#0066cc"
                font.underline: true
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea { anchors.fill: parent }
            }
        }
    }
}
