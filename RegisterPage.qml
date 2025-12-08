// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15
// import App.Api 1.0

// Item {
//     id: regRoot
//     anchors.fill: parent

//     ColumnLayout {
//         anchors.centerIn: parent
//         spacing: 12
//         width: parent.width * 0.7

//         Label { text: "Instructor Registration"; font.pixelSize: 24 }

//         TextField { id: fn; placeholderText: "First Name"; Layout.fillWidth: true }
//         TextField { id: ln; placeholderText: "Last Name"; Layout.fillWidth: true }
//         TextField { id: em; placeholderText: "Email"; Layout.fillWidth: true }
//         TextField {
//             id: pw; placeholderText: "Password"; echoMode: TextInput.Password; Layout.fillWidth: true
//             onTextChanged: updateStrength()
//         }
//         TextField { id: cpw; placeholderText: "Confirm Password"; echoMode: TextInput.Password; Layout.fillWidth: true }

//         Label { id: strengthLabel; text: "" }

//         Button {
//             text: "Register"
//             Layout.fillWidth: true
//             onClicked: {
//                 if (pw.text !== cpw.text) { strengthLabel.text = "Passwords do not match"; return }
//                 ApiClient.post("/api/auth/register", {
//                     firstName: fn.text,
//                     lastName: ln.text,
//                     email: em.text,
//                     password: pw.text
//                 })
//             }
//         }

//         Label { id: registerMsg; text: ""; color: "#0a0" }
//     }

//     function updateStrength() {
//         var p = pw.text
//         var score = 0
//         if (p.length >= 8) score++
//         if (/[A-Z]/.test(p)) score++
//         if (/[0-9]/.test(p)) score++
//         if (/[^A-Za-z0-9]/.test(p)) score++

//         strengthLabel.text = score <= 1 ? "Weak" : score == 2 ? "Medium" : "Strong"
//     }

//     Connections {
//         target: ApiClient
//         onRequestFinished: function(success, message) {
//             if (!success) {
//                 registerMsg.color = "#b00"
//                 registerMsg.text = message
//                 return
//             }
//             registerMsg.color = "#0a0"
//             registerMsg.text = message
//         }
//     }
// }


// // ---- ForgotPassword.qml ----

