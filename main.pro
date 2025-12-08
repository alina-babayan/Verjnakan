
    #QT += quick network charts qml gui
    QT += quick network charts qml gui
    QT += quickdialogs2
    CONFIG += c++17

    TARGET = MyQtApp
    TEMPLATE = app
    HEADERS += \
        ApiEndPoints.h \
        QmlTypes.h \
        TokenStorage.h \
        apiclient.h

    SOURCES += \
    ApiEndpoints.cpp \
        QmlTypes.cpp \
        TokenStorage.cpp \
        apiclient.cpp \
        main.cpp

    RESOURCES += \
        qml.qrc
