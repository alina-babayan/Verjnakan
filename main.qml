import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 1100
    height: 700
    title: "Lumin"
    color: "#ffffff"

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: loginPage

        pushEnter: Transition { PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: 400 } }
        popExit:  Transition { PropertyAnimation { property: "opacity"; from: 1; to: 0; duration: 300 } }
    }

    Component { id: loginPage;      LoginPage { } }
    Component { id: otpPage;        OtpPage { } }
    Component { id: successPage;    LoginSuccessPage { } }
}
