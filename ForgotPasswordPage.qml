import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App.Api 1.0

Item {
    id: forgotRoot
    anchors.fill: parent

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 14
        width: parent.width * 0.7

        Label { text: "Forgot Password"; font.pixelSize: 24 }

        TextField { id: emailFP; placeholderText: "Email"; Layout.fillWidth: true }

        Button {
            text: "Send Reset Link"
            Layout.fillWidth: true
            onClicked: ApiClient.post("/api/auth/forgot-password", { email: emailFP.text })
        }

        Label { id: fpMsg; text: ""; color: "#0a0" }
    }

    Connections {
        target: ApiClient
        onRequestFinished: function(success, message) {
            fpMsg.text = success ? "Email sent!" : message
            fpMsg.color = success ? "#0a0" : "#b00"
        }
    }
}
