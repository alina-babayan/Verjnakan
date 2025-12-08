// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15
// import QtQuick.Controls.Material 2.15

// Item {
//     id: root
//     property var user: ({})  // User data from login (id, email, firstName, lastName, role, etc.)

//     Component.onCompleted: fetchNotifications()  // Load notifications on start

//     ColumnLayout {
//         anchors.fill: parent
//         spacing: 0

//         // Top header bar
//         Rectangle {
//             Layout.fillWidth: true
//             height: 60
//             color: Material.primary  // Blue or custom color

//             RowLayout {
//                 anchors.fill: parent
//                 anchors.margins: 10
//                 spacing: 10

//                 // Logo
//                 Text {
//                     text: "Lumin"
//                     color: "white"
//                     font.pixelSize: 24
//                     font.bold: true
//                 }

//                 Item { Layout.fillWidth: true }  // Spacer

//                 // Search bar (global search, implement logic later)
//                 TextField {
//                     placeholderText: "Search..."
//                     Layout.preferredWidth: 200
//                     onAccepted: console.log("Search: " + text)  // Placeholder
//                 }

//                 // Notifications bell with badge
//                 Button {
//                     icon.name: "notifications"  // Use Material icon or image
//                     flat: true
//                     onClicked: notificationPopup.open()

//                     Rectangle {
//                         anchors.top: parent.top
//                         anchors.right: parent.right
//                         width: 20
//                         height: 20
//                         radius: 10
//                         color: "red"
//                         visible: unreadCount > 0
//                         Text {
//                             anchors.centerIn: parent
//                             text: unreadCount
//                             color: "white"
//                             font.pixelSize: 12
//                         }
//                     }
//                 }

//                 // User profile dropdown
//                 Button {
//                     text: user.firstName + " " + user.lastName
//                     flat: true
//                     onClicked: userMenu.open()

//                     Menu {
//                         id: userMenu
//                         MenuItem {
//                             text: "Settings"
//                             onTriggered: centralStack.push("qrc:/pages/SettingsPage.qml", {user: user})
//                         }
//                         MenuItem {
//                             text: "Logout"
//                             onTriggered: logoutFunction()
//                         }
//                     }
//                 }
//             }
//         }

//         // Main content row: sidebar + central area
//         RowLayout {
//             Layout.fillWidth: true
//             Layout.fillHeight: true
//             spacing: 0

//             // Left sidebar with role-based menu
//             Rectangle {
//                 Layout.fillHeight: true
//                 width: 200
//                 color: Material.background  // Light gray

//                 ListView {
//                     anchors.fill: parent
//                     model: user.role === "admin" ? adminMenu : instructorMenu
//                     delegate: Button {
//                         width: parent.width
//                         height: 50
//                         text: model.text + (model.badge ? " (" + model.badge + ")" : "")
//                         highlighted: ListView.isCurrentItem
//                         onClicked: {
//                             ListView.view.currentIndex = index
//                             centralStack.replace(model.page)
//                         }
//                     }
//                     currentIndex: 0  // Default to first item
//                 }
//             }

//             // Central content area
//             StackView {
//                 id: centralStack
//                 Layout.fillWidth: true
//                 Layout.fillHeight: true
//                 initialItem: user.role === "admin" ? adminMenu.get(0).page : instructorMenu.get(0).page
//             }
//         }
//     }

//     // Notification popup
//     Popup {
//         id: notificationPopup
//         anchors.centerIn: parent
//         width: 300
//         height: 400
//         modal: true
//         focus: true

//         ListView {
//             anchors.fill: parent
//             model: notificationsModel
//             delegate: Rectangle {
//                 width: parent.width
//                 height: 60
//                 color: model.isRead ? "lightgray" : "white"

//                 RowLayout {
//                     anchors.fill: parent
//                     spacing: 10

//                     Text { text: model.title; font.bold: !model.isRead }
//                     Text { text: model.message; Layout.fillWidth: true }
//                 }

//                 MouseArea {
//                     anchors.fill: parent
//                     onClicked: {
//                         if (model.actionUrl) {
//                             // Navigate to actionUrl (implement if needed)
//                             console.log("Navigate to " + model.actionUrl)
//                         }
//                     }
//                 }
//             }
//         }

//         Button {
//             anchors.bottom: parent.bottom
//             anchors.horizontalCenter: parent.horizontalCenter
//             text: "Mark all read"
//             onClicked: markAllRead()
//         }
//     }

//     // Notification model
//     ListModel {
//         id: notificationsModel
//     }

//     property int unreadCount: 0

//     // Fetch notifications
//     function fetchNotifications() {
//         apiClient.get(ApiEndpoints.notifications + "?limit=5", function(response) {
//             if (response.success) {
//                 notificationsModel.clear()
//                 unreadCount = response.data.unreadCount
//                 var notifs = response.data.notifications
//                 for (var i = 0; i < notifs.length; i++) {
//                     notificationsModel.append(notifs[i])
//                 }
//             } else {
//                 console.log("Notifications fetch failed: " + response.message)
//             }
//         })
//     }

//     // Mark all read
//     function markAllRead() {
//         apiClient.put(ApiEndpoints.readAllNotifications, {}, function(response) {
//             if (response.success) {
//                 unreadCount = 0
//                 fetchNotifications()  // Refresh list
//                 notificationPopup.close()
//             } else {
//                 console.log("Mark all read failed: " + response.message)
//             }
//         })
//     }

//     // Logout
//     function logoutFunction() {
//         apiClient.clearToken()
//         stackView.pop(null)  // Clear stack
//         stackView.push("qrc:/pages/LoginPage.qml")
//     }

//     // Sidebar models
//     ListModel {
//         id: adminMenu
//         ListElement { text: "Dashboard"; page: "qrc:/pages/DashboardPage.qml"; badge: "" }  // Pending badge for Instructors later
//         ListElement { text: "Instructors"; page: "qrc:/pages/InstructorsPage.qml"; badge: "" }  // Add pending badge logic
//         ListElement { text: "Courses"; page: "qrc:/pages/CoursesPage.qml"; badge: "" }
//         ListElement { text: "Users"; page: "qrc:/pages/UsersPage.qml"; badge: "" }
//         ListElement { text: "Transactions"; page: "qrc:/pages/TransactionsPage.qml"; badge: "" }
//         ListElement { text: "Settings"; page: "qrc:/pages/SettingsPage.qml"; badge: "" }
//     }

//     ListModel {
//         id: instructorMenu
//         ListElement { text: "Dashboard"; page: "qrc:/pages/DashboardPage.qml"; badge: "" }
//         ListElement { text: "My Courses"; page: "qrc:/pages/MyCoursesPage.qml"; badge: "" }
//         ListElement { text: "Students"; page: "qrc:/pages/StudentsPage.qml"; badge: "" }
//         ListElement { text: "Reviews"; page: "qrc:/pages/ReviewsPage.qml"; badge: "" }
//         ListElement { text: "Settings"; page: "qrc:/pages/SettingsPage.qml"; badge: "" }
//     }
// }


import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15

Item {
    id: root
    property var user: ({})

    Component.onCompleted: {
        fetchNotifications()
        if (user.role === "admin") fetchPendingInstructors()  // Load pending for badge
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            height: 60
            color: Material.primary

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Text {
                    text: "Lumin"
                    color: "white"
                    font.pixelSize: 24
                    font.bold: true
                }

                Item { Layout.fillWidth: true }

                TextField {
                    id: searchField
                    placeholderText: "Search..."
                    Layout.preferredWidth: 200
                    onAccepted: searchFunction(searchField.text)
                }

                Button {
                    icon.name: "notifications"
                    flat: true
                    onClicked: notificationPopup.open()

                    Rectangle {
                        anchors.top: parent.top
                        anchors.right: parent.right
                        width: 20
                        height: 20
                        radius: 10
                        color: "red"
                        visible: unreadCount > 0
                        Text {
                            anchors.centerIn: parent
                            text: unreadCount
                            color: "white"
                            font.pixelSize: 12
                        }
                    }
                }

                Button {
                    text: user.firstName + " " + user.lastName
                    flat: true
                    onClicked: userMenu.open()

                    Menu {
                        id: userMenu
                        MenuItem { text: "Settings"; onTriggered: centralStack.push("qrc:/new/prefix1/SettingsPage.qml", {user: user}) }
                        MenuItem { text: "Logout"; onTriggered: logoutFunction() }
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            Rectangle {
                Layout.fillHeight: true
                width: 200
                color: Material.background

                ListView {
                    anchors.fill: parent
                    model: user.role === "admin" ? adminMenu : instructorMenu
                    delegate: Button {
                        width: parent.width
                        height: 50
                        text: model.text + (model.badge ? " (" + model.badge + ")" : "")
                        highlighted: ListView.isCurrentItem
                        onClicked: {
                            ListView.view.currentIndex = index
                            centralStack.replace(model.page)
                        }
                    }
                    currentIndex: 0
                }
            }

            StackView {
                id: centralStack
                Layout.fillWidth: true
                Layout.fillHeight: true
                initialItem: user.role === "admin" ? adminMenu.get(0).page : instructorMenu.get(0).page
            }
        }
    }

    Popup {
        id: notificationPopup
        anchors.centerIn: parent
        width: 300
        height: 400
        modal: true
        focus: true

        ListView {
            anchors.fill: parent
            model: notificationsModel
            delegate: Rectangle {
                width: parent.width
                height: 60
                color: model.isRead ? "lightgray" : "white"

                RowLayout {
                    anchors.fill: parent
                    spacing: 10

                    Text { text: model.title; font.bold: !model.isRead }
                    Text { text: model.message; Layout.fillWidth: true }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (model.actionUrl) {
                            centralStack.push(model.actionUrl)  // Navigate to actionUrl
                        }
                        notificationPopup.close()
                    }
                }
            }
        }

        Button {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Mark all read"
            onClicked: markAllRead()
        }
    }

    ListModel {
        id: notificationsModel
    }

    property int unreadCount: 0
    property int pendingInstructors: 0  // For badge

    function fetchNotifications() {
        apiClient.get(ApiEndpoints.notifications + "?limit=5", function(response) {
            if (response.success) {
                notificationsModel.clear()
                unreadCount = response.data.unreadCount
                var notifs = response.data.notifications
                for (var i = 0; i < notifs.length; i++) {
                    notificationsModel.append(notifs[i])
                }
            } else {
                console.log("Notifications fetch failed: " + response.message)
            }
        })
    }

    function markAllRead() {
        apiClient.put(ApiEndpoints.readAllNotifications, {}, function(response) {
            if (response.success) {
                unreadCount = 0
                fetchNotifications()
                notificationPopup.close()
            } else {
                console.log("Mark all read failed: " + response.message)
            }
        })
    }

    function fetchPendingInstructors() {
        // Assume endpoint for pending instructors (add to ApiEndpoints if needed)
        apiClient.get(ApiEndpoints.baseUrl + "/api/instructors?status=pending&limit=1", function(response) {
            if (response.success) {
                pendingInstructors = response.data.length || 0
                adminMenu.setProperty(1, "badge", pendingInstructors > 0 ? pendingInstructors : "")
            }
        })
    }

    function searchFunction(query) {
        if (query.length < 2) return  // Min length
        apiClient.get(ApiEndpoints.baseUrl + "/api/search?query=" + query, function(response) {
            if (response.success) {
                centralStack.push("qrc:/new/prefix1/SearchPage.qml", {results: response.data})
            } else {
                console.log("Search failed: " + response.message)
            }
        })
    }

    function logoutFunction() {
        apiClient.clearToken()
        stackView.pop(null)
        stackView.push("qrc:/new/prefix1/LoginPage.qml")
    }

    ListModel {
        id: adminMenu
        ListElement { text: "Dashboard"; page: "qrc:/new/prefix1/DashboardPage.qml"; badge: "" }
        ListElement { text: "Instructors"; page: "qrc:/new/prefix1/InstructorsPage.qml"; badge: "" }
        ListElement { text: "Courses"; page: "qrc:/new/prefix1/CoursesPage.qml"; badge: "" }
        ListElement { text: "Users"; page: "qrc:/new/prefix1/UsersPage.qml"; badge: "" }
        ListElement { text: "Transactions"; page: "qrc:/new/prefix1/TransactionsPage.qml"; badge: "" }
        ListElement { text: "Settings"; page: "qrc:/new/prefix1/SettingsPage.qml"; badge: "" }
    }

    ListModel {
        id: instructorMenu
        ListElement { text: "Dashboard"; page: "qrc:/new/prefix1/DashboardPage.qml"; badge: "" }
        ListElement { text: "My Courses"; page: "qrc:/new/prefix1/MyCoursesPage.qml"; badge: "" }
        ListElement { text: "Students"; page: "qrc:/new/prefix1/StudentsPage.qml"; badge: "" }
        ListElement { text: "Reviews"; page: "qrc:/new/prefix1/ReviewsPage.qml"; badge: "" }
        ListElement { text: "Settings"; page: "qrc:/new/prefix1/SettingsPage.qml"; badge: "" }
    }
}
