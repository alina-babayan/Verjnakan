import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "white"

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // LEFT - Form
        Rectangle {
            Layout.preferredWidth: 480
            Layout.fillHeight: true
            color: "#fafafa"

            Column {
                anchors.centerIn: parent
                width: 360
                spacing: 32

                Rectangle { width: 64; height: 64; radius: 16; color: "#1a1a1a"; anchors.horizontalCenter: parent.horizontalCenter
                    Text { text: "L"; color: "white"; font.pixelSize: 36; font.bold: true; anchors.centerIn: parent }
                }

                Text { text: "Welcome back to Lumin"; font.pixelSize: 28; color: "#1a1a1a"; anchors.horizontalCenter: parent.horizontalCenter }
                Text { text: "Login with your email and password"; color: "#666"; anchors.horizontalCenter: parent.horizontalCenter }

                Column {
                    width: parent.width
                    spacing: 20

                    TextField { placeholderText: "Enter your Email"; width: parent.width }
                    TextField { placeholderText: "Enter your Password"; echoMode: TextInput.Password; width: parent.width }

                    Button {
                        text: "Login"
                        width: parent.width
                        height: 56
                        background: Rectangle { radius: 12; color: "#1a1a1a" }
                        contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }

                        onClicked: {
                            // Իմիտացնում ենք, որ պահանջվում է OTP
                            stack.push(otpPage, { maskedEmail: "j***@gmail.com" })
                        }
                    }
                }
            }
        }

        // RIGHT - Illustration
        Image {
            source: "qrc:new/prefix1/first"
            Layout.fillWidth: true
            Layout.fillHeight: true
            fillMode: Image.PreserveAspectFit
        }
    }
}
