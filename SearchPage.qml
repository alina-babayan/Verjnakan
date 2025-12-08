import QtQuick 2.15

Item {
    property var results: ([])

    Text {
        anchors.centerIn: parent
        text: "Search Results: " + results.length
    }
}
