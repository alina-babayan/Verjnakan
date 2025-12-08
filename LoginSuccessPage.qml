import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    color: "white"

    Column {
        anchors.centerIn: parent
        width: 460
        spacing: 40

        // Success illustration
        Image {
            source: "qrc:new/prefix1/first"
            width: 320
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Column {
            spacing: 16

            Text {
                text: "Login Success"
                font.pixelSize: 32
                font.bold: true
                color: "#1a1a1a"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Welcome back! You're now signed in."
                color: "#555"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: "Start Learning"
                width: 300
                height: 56
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle { radius: 12; color: "#1a1a1a" }
                contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter }

                onClicked: {
                    console.log("Բարի գալուստ Dashboard!")
                    // stack.push("qrc:/Dashboard.qml")
                }
            }
        }
    }
}
