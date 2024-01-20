import QtQuick 2.15
import QtQuick.XmlListModel 2.0
import QtQuick.Controls.Styles 1.1
import QtQuick.Controls.Material 2.3
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Dialogs 1.1
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4 as Quick
import QtQuick.Layouts 1.1
import QtLocation 5.6
import QtPositioning 5.6
import QtCharts 2.3
import QtQuick.Controls 2.0 as C2
import "qrc:/JavaScriptsFunction.js" as ParamScript

ApplicationWindow {
    id:mainn

    width: 900
    height: 250
    minimumHeight: 500
    minimumWidth: 250
    visible: true
    Material.theme: Material.Light
    Material.accent: "#428158"
    Material.primary: Material.Grey
    title: qsTr("CUDA Examples")

    // MM No Limits:
    signal setSizeMatrices(var d)
    signal seteMatricesValue(var d)
    signal minMaxSendTo(var d, var d2)
    signal startShowResult()


    function timeGPU(num){
        mMGPUDuration.text=num
    }
    function timeCPU(num){
        mMCPUDuration.text=num
    }
    function sendResults(num){
        console.log("oomad",num)
        textConsole.append(num + ",")
    }



    // MM With Limits:
    signal setSizeMatrices2(var d)
    signal seteMatricesValue2(var d)
    signal minMaxSendTo2(var d, var d2)
    signal startShowResult2()


    function timeGPU2(num){
        mMGPUDuration2.text=num
    }
    function timeCPU2(num){
        mMCPUDuration2.text=num
    }
    function sendResults2(num){
        console.log("oomad",num)
        textConsole2.append(num + ",")
    }

    // VA With Limits:
    signal setSizeMatrices4(var d)
    signal seteMatricesValue4(var d)
    signal minMaxSendTo4(var d, var d2)
    signal startShowResult4()


    function timeGPU4(num){
//        mMGPUDuration4.text=num
    }
    function timeCPU4(num){
        mMCPUDuration4.text=num
    }
    function sendResults4(num){
        console.log("oomad",num)
        textConsole4.append(num + ",")
    }

    //--------------------------------------------------------------------------------

    Popup {
        id: popup
        x: parent.width - width
        y: parent.height - height
        width: 100
        height: 50

        background: Rectangle {
            id: background
            color: "#D3D3D3"
            anchors.fill: parent
        }

        Label {
            id: label
            text: "LOGGING"
            anchors.centerIn: parent
        }

        Timer {
            id: timer
            interval: 4000
            repeat: false
            onTriggered: popup.close()
        }

        onVisibleChanged: {
            if (visible) {
                colorAnimation.start()
                timer.restart()
            }
        }

        ColorAnimation {
            id: colorAnimation
            target: background
            //oncomplet    if popup is active do this
            from: "white"
            to: "grey"
            duration: 2000
        }

    }

    Popup {
        id: popupstop
        x: parent.width - width
        y: parent.height - height
        width: 150
        height: 50

        background: Rectangle {
            color: "#D3D3D3"
            anchors.fill: parent
        }
        Label {
            id: label2
            text: "Stopping Conver..."
            anchors.centerIn: parent
        }

        Timer {
            id: timer2
            interval: 2000
            repeat: false
            onTriggered: popupstop.close()
        }

        onVisibleChanged: {
            if (visible) {
                timer2.restart()
            }
        }
    }

    Popup {
        id: popupclean
        x: parent.width - width
        y: parent.height - height
        width: 100
        height: 50

        background: Rectangle {
            color: "#D3D3D3"
            anchors.fill: parent
        }

        Label {
            id: label3
            text: "Cleaning..."
            anchors.centerIn: parent
        }

        Timer {
            id: timer3
            interval: 3000
            repeat: false
            onTriggered: popupclean.close()
        }

        onVisibleChanged: {
            if (visible) {
                timer3.restart()
            }
        }
    }

    Popup {
        id: popupmap
        x: parent.width - width
        y: parent.height - height
        width: 150
        height: 50

        background: Rectangle {
            color: "#D3D3D3"
            anchors.fill: parent
        }

        Label {
            id: label4
            text: "Map is Opened..."
            anchors.centerIn: parent
        }
        onVisibleChanged: {
            if (visible) {
                timer4.restart()
            }
        }
    }

    //--------------------------------------------------------------------------------

    SplitView{
        anchors.fill: parent
        orientation: Qt.Horizontal
        Page{
            id:page1
            implicitWidth: 340
            implicitHeight: parent.height

            GroupBox{
                id:maingr
                anchors.left: parent.left
                implicitWidth: parent.width
                implicitHeight: parent.height
                ScrollView {
                    //                    anchors.fill: parent
                    implicitWidth:parent.width
                    implicitHeight:mainn.height-50
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    ScrollBar.vertical.policy: ScrollBar.AsNeeded
                    ScrollBar.horizontal.policy: ScrollBar.AsNeeded
                    ColumnLayout{
                        implicitWidth: parent.width
                        Layout.alignment: Qt.AlignCenter
                        GroupBox{
                            Layout.alignment: Qt.AlignCenter

                            title: qsTr("Set Params")
                            id:mainGroupBox
                            font.bold: true
                            implicitHeight: 250
                            implicitWidth: 310
                            //                            Layout.alignment: Qt.AlignBottom
                            y:-200


                            MouseArea {
                                id: mouseArea5
                                anchors.fill: parent
                                hoverEnabled: true

                                onPositionChanged: {
                                    greenLightDance5.start()
                                    borderWidthAnimation5.start()
                                    mainGroupBox.x += mouse.x - mouse.startX;
                                    mainGroupBox.y += mouse.y - mouse.startY;
                                }
                                drag.target: mainGroupBox

                                onWheel: {
                                    var zoomFactor = 1.1;
                                    if (wheel.angleDelta.y > 0) {
                                        mainGroupBox.scale *= zoomFactor;
                                    } else {
                                        mainGroupBox.scale /= zoomFactor;
                                    }
                                }
                            }

                            background: Rectangle {
                                id: greenLight5
                                //                                    anchors.fill: parent
                                //                                    implicitHeight: parent.height
                                //                                    implicitWidth: parent.width
                                border.color: "#b3b3b3"
                                border.width: 1
                            }
                            PropertyAnimation {
                                id: borderWidthAnimation5
                                target: greenLight5
                                property: "border.width"
                                from: 3
                                to: 1
                                duration: 2000
                            }
                            SequentialAnimation {
                                id: greenLightDance5

                                ColorAnimation {
                                    target: greenLight5
                                    property: "border.color"
                                    from: "#b3b3b3"
                                    to: "#17a531"
                                    duration: 500
                                }
                                ColorAnimation {
                                    target: greenLight5
                                    property: "border.color"
                                    from: "#17a531"
                                    to: "#b3b3b3"
                                    duration: 50

                                }

                            }
                            StackLayout {
                                width: parent.width
                                currentIndex: bar.currentIndex
                                Item {
                                    anchors.fill:parent
                                    RowLayout {
                                        spacing: 40
                                        anchors.fill: parent
                                        ColumnLayout{
                                            y:50
                                            spacing:50
                                            clip:true

                                            Label {
                                                id:aMatric
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Size Matrix A:"
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                id:bMatric
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Size Matrix B:"
                                                font.pixelSize: 12
                                            }

                                            Label {
                                                id:valuesMatrix
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Set Values:"
                                                font.pixelSize: 12
                                            }
                                        }
                                        ColumnLayout{
                                            clip:true
                                            spacing: 25
                                            anchors.top: parent.top
                                            TextArea {
                                                id:aMatricSize
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "100"
                                                horizontalAlignment: Text.AlignHCenter
                                                font.pixelSize: 12
                                                onTextChanged: {
                                                    setSizeMatrices(aMatricSize.text)
                                                }
                                            }
                                            TextArea {
                                                id:bMatricSize
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "100"
                                                horizontalAlignment: Text.AlignHCenter
                                                onTextChanged: {
                                                    setSizeMatrices(bMatricSize.text)
                                                }
                                                font.pixelSize: 12
                                            }
                                            RowLayout{
                                                spacing: 20
                                                ComboBox {
                                                    implicitWidth: 100
                                                    id: comboBoxseials
                                                    font.pixelSize: 10
                                                    anchors.centerIn: parent.Center
                                                    model: ["Choose one","Random","Value: 1","Value: 2","Other"]
                                                    onActivated: {
                                                        if(comboBoxseials.currentText=="Random"){
                                                            ParamScript.changeenabledToFalse(setValueM)
                                                            seteMatricesValue(0)
                                                        }
                                                        if(comboBoxseials.currentText=="Value: 1"){
                                                            ParamScript.changeenabledToFalse(setValueM)
                                                            seteMatricesValue(1)
                                                        }
                                                        if(comboBoxseials.currentText=="Value: 2"){
                                                            ParamScript.changeenabledToFalse(setValueM)
                                                            seteMatricesValue(2)
                                                        }
                                                        if(comboBoxseials.currentText=="Other"){
                                                            ParamScript.changeenabledToTrue(setValueM)
                                                        }
                                                    }
                                                    Material.foreground: "#2ac924"
                                                }
                                                TextArea {
                                                    id:setValueM
                                                    implicitWidth: 50
                                                    font.bold: false
                                                    enabled: false
                                                    clip:true
                                                    x:-2
                                                    placeholderText: "..."
                                                    horizontalAlignment: Text.AlignHCenter
                                                    font.pixelSize: 12
                                                    onTextChanged: {
                                                        seteMatricesValue(setValueM.text)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                Item {
                                    anchors.fill:parent
                                    RowLayout {
                                        spacing: 40
                                        anchors.fill: parent
                                        ColumnLayout{
                                            y:50
                                            spacing:50
                                            clip:true

                                            Label {
                                                id:aMatric2
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Size Matrix A:"
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                id:bMatric2
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Size Matrix B:"
                                                font.pixelSize: 12
                                            }

                                            Label {
                                                id:valuesMatrix2
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Set Values:"
                                                font.pixelSize: 12
                                            }
                                        }
                                        ColumnLayout{
                                            clip:true
                                            spacing: 25
                                            anchors.top: parent.top
                                            TextArea {
                                                id:aMatricSize2
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "100"
                                                horizontalAlignment: Text.AlignHCenter
                                                onTextChanged: {
                                                    setSizeMatrices2(aMatricSize.text)
                                                }
                                                font.pixelSize: 12
                                            }
                                            TextArea {
                                                id:bMatricSize2
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "100"
                                                horizontalAlignment: Text.AlignHCenter
                                                onTextChanged: {
                                                    setSizeMatrices2(bMatricSize.text)
                                                }
                                                font.pixelSize: 12
                                            }
                                            RowLayout{
                                                spacing: 20
                                                ComboBox {
                                                    implicitWidth: 100
                                                    id: comboBoxseials2
                                                    font.pixelSize: 10
                                                    anchors.centerIn: parent.Center
                                                    model: ["Choose one","Random","Value: 1","Value: 2","Other"]
                                                    onActivated: {
                                                        if(comboBoxseials2.currentText=="Random"){
                                                            ParamScript.changeenabledToFalse(setValueM2)
                                                            seteMatricesValue2(0)
                                                        }
                                                        if(comboBoxseials2.currentText=="Value: 1"){
                                                            ParamScript.changeenabledToFalse(setValueM2)
                                                            seteMatricesValue2(1)
                                                        }
                                                        if(comboBoxseials2.currentText=="Value: 2"){
                                                            ParamScript.changeenabledToFalse(setValueM2)
                                                            seteMatricesValue2(2)
                                                        }
                                                        if(comboBoxseials2.currentText=="Other"){
                                                            ParamScript.changeenabledToTrue(setValueM2)
                                                        }
                                                    }
                                                    Material.foreground: "#2ac924"
                                                }
                                                TextArea {
                                                    id:setValueM2
                                                    implicitWidth: 50
                                                    font.bold: false
                                                    enabled: false
                                                    clip:true
                                                    x:-2
                                                    placeholderText: "..."
                                                    horizontalAlignment: Text.AlignHCenter
                                                    font.pixelSize: 12
                                                    onTextChanged: {
                                                        seteMatricesValue2(setValueM2.text)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                Item {
                                    anchors.fill:parent
                                    RowLayout {
                                        spacing: 40
                                        anchors.fill: parent
                                        ColumnLayout{
                                            y:50
                                            spacing:50
                                            clip:true

                                            Label {
                                                id:aVec1
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Size Vector A:"
                                                font.pixelSize: 12
                                            }

                                            Label {
                                                id:valuesVec1
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Set Values:"
                                                font.pixelSize: 12
                                            }
                                        }
                                        ColumnLayout{
                                            clip:true
                                            spacing: 25
                                            anchors.top: parent.top
                                            TextArea {
                                                id:aVecSize2
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "100"
                                                horizontalAlignment: Text.AlignHCenter
                                                font.pixelSize: 12
                                            }

                                            RowLayout{
                                                spacing: 20
                                                ComboBox {
                                                    implicitWidth: 100
                                                    id: comboBoxVec1
                                                    font.pixelSize: 10
                                                    anchors.centerIn: parent.Center
                                                    model: ["Choose one","Random","Value: 1","Value: 2","Other"]
                                                    onActivated: {
                                                        if(comboBoxseials.currentText=="Random"){
                                                            ParamScript.changeenabledToFalse(setValueV1)
                                                        }
                                                        if(comboBoxseials.currentText=="Value: 1"){
                                                            ParamScript.changeenabledToFalse(setValueV1)
                                                        }
                                                        if(comboBoxseials.currentText=="Value: 2"){
                                                            ParamScript.changeenabledToFalse(setValueV1)
                                                        }
                                                        if(comboBoxseials.currentText=="Other"){
                                                            ParamScript.changeenabledToTrue(setValueV1)
                                                        }
                                                    }
                                                    Material.foreground: "#2ac924"
                                                }
                                                TextArea {
                                                    id:setValueV1
                                                    implicitWidth: 50
                                                    font.bold: false
                                                    enabled: false
                                                    clip:true
                                                    x:-2
                                                    placeholderText: "..."
                                                    horizontalAlignment: Text.AlignHCenter
                                                    font.pixelSize: 12
                                                }
                                            }
                                        }
                                    }
                                }
                                Item {
                                    anchors.fill:parent
                                    RowLayout {
                                        spacing: 40
                                        anchors.fill: parent
                                        ColumnLayout{
                                            y:50
                                            spacing:50
                                            clip:true

                                            Label {
                                                id:aVec2
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Size Vector A:"
                                                font.pixelSize: 12
                                            }

                                            Label {
                                                id:valuesVec2
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Set Values:"
                                                font.pixelSize: 12
                                            }
                                        }
                                        ColumnLayout{
                                            clip:true
                                            spacing: 25
                                            anchors.top: parent.top
                                            TextArea {
                                                id:aVecSize1
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "100"
                                                horizontalAlignment: Text.AlignHCenter
                                                font.pixelSize: 12
                                            }

                                            RowLayout{
                                                spacing: 20
                                                ComboBox {
                                                    implicitWidth: 100
                                                    id: comboBoxVec2
                                                    font.pixelSize: 10
                                                    anchors.centerIn: parent.Center
                                                    model: ["Choose one","Random","Value: 1","Value: 2","Other"]
                                                    onActivated: {
                                                        if(comboBoxseials.currentText=="Random"){
                                                            ParamScript.changeenabledToFalse(setValueV2)
                                                        }
                                                        if(comboBoxseials.currentText=="Value: 1"){
                                                            ParamScript.changeenabledToFalse(setValueV2)
                                                        }
                                                        if(comboBoxseials.currentText=="Value: 2"){
                                                            ParamScript.changeenabledToFalse(setValueV2)
                                                        }
                                                        if(comboBoxseials.currentText=="Other"){
                                                            ParamScript.changeenabledToTrue(setValueV2)
                                                        }
                                                    }
                                                    Material.foreground: "#2ac924"
                                                }
                                                TextArea {
                                                    id:setValueV2
                                                    implicitWidth: 50
                                                    font.bold: false
                                                    enabled: false
                                                    clip:true
                                                    x:-2
                                                    placeholderText: "..."
                                                    horizontalAlignment: Text.AlignHCenter
                                                    font.pixelSize: 12
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                        }
                        RowLayout{
                            Button {
                                Layout.alignment: Qt.AlignCenter
                                clip:true
                                enabled: true
                                font.bold:false
                                implicitHeight: 40
                                implicitWidth: 150
                                text: "Press to Start on GPU"
                                font.pixelSize: 10
                                onClicked: {
                                    if(bar.currentIndex===0)
                                        mMNoLimit.functionCuda()
                                    else if(bar.currentIndex===1)
                                        mMWithLimit.functionCuda()
                                    else if(bar.currentIndex===3)
                                        vAWithLimit.functionCuda()
                                }
                            }
                            Button {
                                Layout.alignment: Qt.AlignCenter
                                clip:true
                                enabled: true
                                font.bold:false
                                implicitHeight: 40
                                implicitWidth: 150
                                text: "Press to Start on CPU"
                                font.pixelSize: 10
                                onClicked: {
                                    if(bar.currentIndex===0)
                                        mMNoLimit.functionNoCuda()
                                    else if(bar.currentIndex===1)
                                        mMWithLimit.functionNoCuda()
                                    else if(bar.currentIndex===3)
                                        vAWithLimit.functionNoCuda()
                                }
                            }
                        }
                    }
                }
            }
        }
        Page{
            Material.theme: Material.Dark
            anchors.top:parent.top
            id:page2
            Material.accent: "#428158"
            Material.primary: Material.Grey
            implicitWidth: mainn.width-page1.width
            implicitHeight: mainn.height
            Keys.onPressed: {
                if (event.key === Qt.Key_Escape && mainn.visibility === Window.FullScreen) {
                    ParamScript.changecolorcsvnotactive(fullwin)
                    mainn.visibility = Window.Windowed
                    flagfullWin=false
                }
            }
            ColumnLayout{
                implicitHeight: parent.height
                implicitWidth: parent.width
                TabBar {
                    implicitWidth: page2.width
                    background: color="black"
                    id: bar
                    TabButton {
                        text: qsTr("No Limit MM")
                        onClicked: {
                            mainGroupBox.implicitHeight=210
                        }
                    }
                    TabButton {
                        text: qsTr("Limit MM")
                        onClicked: {
                            mainGroupBox.implicitHeight=210
                        }
                    }
                    TabButton {
                        text: qsTr("No Limit VA")
                        onClicked: {
                            mainGroupBox.implicitHeight=160
                        }
                    }
                    TabButton {
                        text: qsTr("Limit VA")
                        onClicked: {
                            mainGroupBox.implicitHeight=160
                        }
                    }
                }

                StackLayout {
                    id:stack
                    implicitWidth: parent.width-bar.width
                    currentIndex: bar.currentIndex
                    Item {
                        id: poseaccuracy
                        anchors.fill:parent
                        ColumnLayout{
                            GroupBox{
                                implicitHeight: (mainn.height - bar.height)
                                implicitWidth: stack.width
                                ColumnLayout{
                                    spacing: 30
                                    RowLayout{
                                        spacing: 70
                                        ColumnLayout{
                                            spacing: 50
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Duration on GPU:"
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Duration on CPU:"
                                                font.pixelSize: 12
                                            }
                                        }
                                        ColumnLayout{
                                            spacing: 50
                                            Label {
                                                id:mMGPUDuration
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "...  MS"
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                id:mMCPUDuration
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "...  MS"
                                                font.pixelSize: 12
                                            }
                                        }
                                    }
                                    RowLayout{
                                        spacing: 50
                                        RowLayout{
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "From"
                                                font.pixelSize: 12
                                            }
                                            TextArea {
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "0"
                                                horizontalAlignment: Text.AlignHCenter
                                                font.pixelSize: 12
                                                onTextChanged: {
                                                    minMaxSendTo(text,"Min")
                                                }
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "to"
                                                font.pixelSize: 12
                                            }
                                            TextArea {
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "256"
                                                horizontalAlignment: Text.AlignHCenter
                                                font.pixelSize: 12
                                                onTextChanged: {
                                                    minMaxSendTo(text,"Max")
                                                }
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "::::"
                                                font.pixelSize: 12
                                            }
                                        }
                                        Button {
                                            Layout.alignment: Qt.AlignCenter
                                            clip:true
                                            enabled: true
                                            font.bold:false
                                            implicitHeight: 40
                                            implicitWidth: 150
                                            text: "Press to See The Result"
                                            font.pixelSize: 10
                                            onClicked: {
                                                startShowResult()
                                            }
                                        }
                                    }
                                    ScrollView{
                                        implicitHeight: 200
                                        implicitWidth: 200
                                        clip: true
                                        TextArea {
                                            id:textConsole
                                            background: Pane{
                                                implicitHeight: 200
                                                implicitWidth: 200
                                            }
                                            width: 300
                                            height: 300
                                            font.pointSize: 10
                                            color: "#4aee18"
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Item {
                        id: latlong
                        ColumnLayout{
                            GroupBox{
                                implicitHeight: (mainn.height - bar.height)
                                implicitWidth: stack.width
                                ColumnLayout{
                                    spacing: 30
                                    RowLayout{
                                        spacing: 70
                                        ColumnLayout{
                                            spacing: 50
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Duration on GPU:"
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Duration on CPU:"
                                                font.pixelSize: 12
                                            }
                                        }
                                        ColumnLayout{
                                            spacing: 50
                                            Label {
                                                id:mMGPUDuration2
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "...  MS"
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                id:mMCPUDuration2
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "...  MS"
                                                font.pixelSize: 12
                                            }
                                        }
                                    }
                                    RowLayout{
                                        spacing: 50
                                        RowLayout{
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "From"
                                                font.pixelSize: 12
                                            }
                                            TextArea {
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "0"
                                                horizontalAlignment: Text.AlignHCenter
                                                onTextChanged: {
                                                    minMaxSendTo2(text,"Min")
                                                }
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "to"
                                                font.pixelSize: 12
                                            }
                                            TextArea {
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "256"
                                                horizontalAlignment: Text.AlignHCenter
                                                onTextChanged: {
                                                    minMaxSendTo2(text,"Max")
                                                }
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "::::"
                                                font.pixelSize: 12
                                            }
                                        }
                                        Button {
                                            Layout.alignment: Qt.AlignCenter
                                            clip:true
                                            enabled: true
                                            font.bold:false
                                            implicitHeight: 40
                                            implicitWidth: 150
                                            text: "Press to See The Result"
                                            onClicked: {
                                                startShowResult2()
                                            }
                                            font.pixelSize: 10
                                        }
                                    }
                                    ScrollView{
                                        implicitHeight: 200
                                        implicitWidth: 200
                                        clip: true
                                        TextArea {
                                            id:textConsole2
                                            background: Pane{
                                                implicitHeight: 200
                                                implicitWidth: 200
                                            }
                                            width: 300
                                            height: 300
                                            font.pointSize: 10
                                            color: "#4aee18"
                                        }
                                    }
                                }
                            }
                        }

                    }
                    Item {
                        id: pdopp
                        ColumnLayout{
                            GroupBox{
                                implicitHeight: (mainn.height - bar.height)
                                implicitWidth: stack.width
                                ColumnLayout{
                                    spacing: 30
                                    RowLayout{
                                        spacing: 70
                                        ColumnLayout{
                                            spacing: 50
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Duration on GPU:"
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Duration on CPU:"
                                                font.pixelSize: 12
                                            }
                                        }
                                        ColumnLayout{
                                            spacing: 50
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "...  MS"
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "...  MS"
                                                font.pixelSize: 12
                                            }
                                        }
                                    }
                                    RowLayout{
                                        spacing: 50
                                        RowLayout{
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "From"
                                                font.pixelSize: 12
                                            }
                                            TextArea {
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "0"
                                                horizontalAlignment: Text.AlignHCenter
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "to"
                                                font.pixelSize: 12
                                            }
                                            TextArea {
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "256"
                                                horizontalAlignment: Text.AlignHCenter
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "::::"
                                                font.pixelSize: 12
                                            }
                                        }
                                        Button {
                                            Layout.alignment: Qt.AlignCenter
                                            clip:true
                                            enabled: true
                                            font.bold:false
                                            implicitHeight: 40
                                            implicitWidth: 150
                                            text: "Press to See The Result"
                                            font.pixelSize: 10
                                        }
                                    }
                                    TextArea {
                                        background: Pane{
                                            implicitHeight: 200
                                            implicitWidth: 200
                                        }
                                        width: 300
                                        height: 300
                                        font.pointSize: 10
                                        color: "#4aee18"
                                    }
                                }
                            }
                        }

                    }
                    Item {
                        id: velocity
                        ColumnLayout{
                            GroupBox{
                                implicitHeight: (mainn.height - bar.height)
                                implicitWidth: stack.width
                                ColumnLayout{
                                    spacing: 30
                                    RowLayout{
                                        spacing: 70
                                        ColumnLayout{
                                            spacing: 50
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Duration on GPU:"
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "Duration on CPU:"
                                                font.pixelSize: 12
                                            }
                                        }
                                        ColumnLayout{
                                            spacing: 50
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "...  MS"
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "...  MS"
                                                font.pixelSize: 12
                                            }
                                        }
                                    }
                                    RowLayout{
                                        spacing: 50
                                        RowLayout{
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "From"
                                                font.pixelSize: 12
                                            }
                                            TextArea {
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "0"
                                                horizontalAlignment: Text.AlignHCenter
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "to"
                                                font.pixelSize: 12
                                            }
                                            TextArea {
                                                implicitWidth: 50
                                                font.bold: false
                                                clip:true
                                                x:-2
                                                placeholderText: "256"
                                                horizontalAlignment: Text.AlignHCenter
                                                font.pixelSize: 12
                                            }
                                            Label {
                                                clip:true
                                                font.bold: false
                                                x:-2
                                                text: "::::"
                                                font.pixelSize: 12
                                            }
                                        }
                                        Button {
                                            Layout.alignment: Qt.AlignCenter
                                            clip:true
                                            enabled: true
                                            font.bold:false
                                            implicitHeight: 40
                                            implicitWidth: 150
                                            text: "Press to See The Result"
                                            font.pixelSize: 10
                                        }
                                    }
                                    TextArea {
                                        background: Pane{
                                            implicitHeight: 200
                                            implicitWidth: 200
                                        }
                                        width: 300
                                        height: 300
                                        font.pointSize: 10
                                        color: "#4aee18"
                                    }
                                }
                            }
                        }

                    }
                }
            }
        }
    }


}

