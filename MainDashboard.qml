import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
Item {
    Column {
        anchors.centerIn: parent
        spacing: 20
        Text {
            text: "Բարի գալուստ Lumin!"
            font.pixelSize: 24
            font.bold: true
            color: Material.primary
        }
        Text {
            text: "Դուք հաջողությամբ մուտք եք գործել"
            font.pixelSize: 16
        }
        Button {
            text: "Logout"
            onClicked: {
                apiClient.clearToken()
                stackView.pop(StackView.Immediate)
                stackView.clear()
                stackView.push("qrc:/new/prefix1/LoginPage.qml")
            }
        }
    }
}
