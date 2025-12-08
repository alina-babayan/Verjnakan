import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

Item {
    default property alias content: column.data

    ColumnLayout {
        id: column
        anchors.centerIn: parent
        spacing: 30

        Text {
            text: message || "Success!"
            font.pixelSize: 28
            font.bold: true
            color: "#198754"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: status || ""
            font.pixelSize: 18
            color: "#495057"
            visible: status
            Layout.alignment: Qt.AlignHCenter
        }

        Button {
            text: "Continue →"
            Layout.alignment: Qt.AlignHCenter
            onClicked: stack.pop(null) // դուրս գալ բոլոր էջերից դեպի login
        }
    }
}
