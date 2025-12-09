import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    color: "white"

    Column {
        anchors.centerIn: parent
        spacing: 40

        Text {
            text: "Login Success!"
            font.pixelSize: 36
            font.bold: true
            color: "#1a1a1a"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "Welcome back!"
            font.pixelSize: 20
            color: "#555"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Start Learning"
            width: 300; height: 56
            background: Rectangle { radius: 14; color: "#1a1a1a" }
            contentItem: Text { text: parent.text; color: "white"; font.bold: true; font.pixelSize: 18; horizontalAlignment: Text.AlignHCenter }

            onClicked: console.log("Բարի գալուստ Dashboard!")
        }
    }
}
