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
            anchors.fill: parent
            implicitWidth:parent.width
            height:1100
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            ScrollBar.horizontal.policy: ScrollBar.AsNeeded
            ColumnLayout{
                implicitWidth: parent.width
                RowLayout{
                    spacing:15
                    ToolButton {
                        id: toolButton
                        text: stackView.depth > 1 ? "\u25C0" : "\u2630"
                        font.pixelSize: Qt.application.font.pixelSize * 1.6
                        onClicked: {
                            if (stackView.depth > 1) {
                                stackView.pop()
                            } else {
                                serialsdrawer.open()
                            }
                        }
                    }
                    ComboBox {
                        //                                    x:40
                        implicitWidth: 170
                        id: comboBoxseials
                        //                                anchors.left: parent.left
                        //                                Layout.alignment: Qt.AlignCenter
                        anchors.centerIn: parent.Center
                        model: ["Choose one","Trimble","U-Blox","Serialqb90"]
                        onActivated: {
                            if(comboBoxseials.currentText=="Trimble"){
                                ParamScript.changeActiveToTrue(loadertrimble)
                            }
                            if(comboBoxseials.currentText=="U-Blox"){
                                ParamScript.changeActiveToTrue(loaderublox)
                            }
                            if(comboBoxseials.currentText=="Serialqb90"){
                                ParamScript.changeActiveToTrue(serialqb)
                            }
                        }
                        Material.foreground: "#2ac924"
                    }
                    MenuBarItem{
                        y:10
                        id:tabView
                        height: 30
                        width: 30
                        transform: Translate {x: 2}
                        highlighted:false
                        icon.source:"/qml/gps.png"

                        icon.color: "transparent"
                        icon.width: 30
                        icon.height: 30
                        onClicked: {
                            menuId.open()
                            tabView.highlighted=false
                            tabView.hoverEnabled=false
                        }
                        onHighlightedChanged: {
                            tabView.highlighted=false
                            tabView.hoverEnabled=false
                        }
                        bottomPadding:-10
                        Menu{
                            y:50
                            id:menuId
                            Menu{
                                id:tabNMEA
                                title: "Map"
                                MenuItem {

                                    Button{
                                        implicitWidth: parent.width
                                        implicitHeight: parent.height
                                        text: "Map View"
                                        onClicked: {
                                            loadermap.active=true
                                            tabView.hoverEnabled=false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                RowLayout{
                    spacing:15
                    id:rowCSV
                    Button {
                        clip:true
                        id:foldercsv
                        background: {
                            clip:true
                            color="transparent"
                        }
                        icon.source:  "/qml/csv.ico"
                        icon.color: "#9cd7b6"
                        onClicked: {
                            if(!flagcsv){
                                csvStart()
                                ParamScript.changecolorcsvactive(foldercsv)
                                flagcsv=true
                            }
                            else{
                                csvStop()
                                ParamScript.changecolorcsvnotactive(foldercsv)
                                flagcsv=false
                            }
                        }
                    }
                    Button{
                        font.pixelSize: 10
                        id:stopConvert
                        implicitWidth: 200
                        implicitHeight: 30
                        text:qsTr("Stop Converting")
                        onClicked:{
                            csvStop()
                            ParamScript.changecolorcsvnotactive(foldercsv)
                            flagcsv=false
                        }
                    }
                    Button {
                        id:crcbut
                        clip:true
                        enabled: true
                        font.bold:false
                        implicitHeight: 30
                        implicitWidth: 30
                        text: "Click to See GGA Messages"
                        font.pixelSize: 10
                        onClicked: {
                            ParamScript.changecolorcsvnotactive(foldercsv)
                            ParamScript.changeActiveToTrue(loader)
                            ParamScript.changeVisibleToTrue(loaderWindow)
                        }
                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignCenter
                    spacing: 50
                    Label {
                        enabled: true
                        clip:true
                        font.bold: true
                        text: "Points:"
                        font.pixelSize: 12

                    }
                    TextField {
                        implicitWidth: 30
                        implicitHeight: 40
                        placeholderText: "100"
                        onTextChanged: pointschange(text);
                        horizontalAlignment: Text.AlignHCenter | Text.AlignBottom
                        font.pixelSize: 10
                    }
                }
                GroupBox{
                    title: qsTr("Plot Info")
                    id:mainGroupBox
                    font.bold: true
                    implicitHeight: 110
                    implicitWidth: 310
                    Layout.alignment: Qt.AlignBottom
                    y:-200
                    StackLayout {
                        width: parent.width
                        currentIndex: bar.currentIndex
                        Item {
                            id: poseaccuracy1
                            anchors.fill:parent
                            RowLayout {
                                spacing: 50
                                ColumnLayout{
                                    spacing:30
                                    clip:true
//                                            Label {
//                                                id:trimposacc
//                                                enabled: false
//                                                clip:true
//                                                font.bold: false
//                                                x:-2
//                                                text: "Trimble PosAccuracy:"
//                                                font.pixelSize: 12
//                                            }
                                    Label {
                                        id:ubloxposacc
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "U_Blox PosAccuracy:"
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqposacc
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "Q PosAccuracy:"
                                        font.pixelSize: 12
                                    }
                                }
                                ColumnLayout{
                                    spacing:30
                                    clip:true
//                                            Label {
//                                                id:trimposaccnum
//                                                enabled: false
//                                                font.bold: false
//                                                clip:true
//                                                x:-2
//                                                text: "0"
//                                                horizontalAlignment: Text.AlignHCenter
//                                                font.pixelSize: 12
//                                            }
                                    Label {
                                        id:ubloxposaccnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqposaccnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                }
                            }
                        }
                        Item {
                            id: latLongAlt
                            RowLayout {
                                spacing: 20
                                ColumnLayout{
                                    spacing:30
                                    clip:true
                                    Label {
                                        id:trimlatLongAlt
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "Trimble latLongAlt:"
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:ubloxlatLongAlt
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "U_Blox latLongAlt:"
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqlatLongAlt
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "Q latLongAlt:"
                                        font.pixelSize: 12
                                    }
                                }
                                ColumnLayout{
                                    clip:true
                                    spacing:30
                                    Label {
                                        id:trimlatLongAltcnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:ubloxlatLongAltnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqlatLongAltnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                }
                                ColumnLayout{
                                    clip:true
                                    spacing:30
                                    Label {
                                        id:trimlatLongcnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:ubloxlatLongnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqlatLongnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                }
                                ColumnLayout{
                                    clip:true
                                    spacing:30
                                    Label {
                                        id:trimlatcnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:ubloxlatnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqlatnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                }
                            }
                        }
                        Item {
                            id: pdopp1
                            RowLayout {
                                spacing: 80
                                ColumnLayout{
                                    spacing:30
                                    clip:true
                                    Label {
                                        id:trimpdop
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "Trimble PDOP:"
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:ubloxpdopp
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "U_Blox PDOP:"
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqpdop
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "Q PDOP:"
                                        font.pixelSize: 12
                                    }
                                }
                                ColumnLayout{
                                    spacing:30
                                    clip:true
                                    Label {
                                        id:trimpdopcnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:ubloxpdopnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqpdopnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                }
                            }
                        }
                        Item {
                            id: velocity1
                            RowLayout {
                                spacing: 80
                                ColumnLayout{
                                    spacing:30
                                    clip:true
//                                            Label {
//                                                id:trimVEL
//                                                enabled: false
//                                                clip:true
//                                                font.bold: false
//                                                x:-2
//                                                text: "Trimble Velocity:"
//                                                font.pixelSize: 12
//                                            }
                                    Label {
                                        id:ubloxVEL
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "U_Blox Velocity:"
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqVEL
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "Q Velocity:"
                                        font.pixelSize: 12
                                    }
                                }
                                ColumnLayout{
                                    spacing:30
                                    clip:true
//                                            Label {
//                                                id:trimVELnum
//                                                enabled: false
//                                                font.bold: false
//                                                clip:true
//                                                x:-2
//                                                text: "0"
//                                                horizontalAlignment: Text.AlignHCenter
//                                                font.pixelSize: 12
//                                            }
                                    Label {
                                        id:ubloxVELnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqVELum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                }
                            }
                        }
                        Item {
                            id: tOW
                            RowLayout {
                                spacing: 80
                                ColumnLayout{
                                    spacing:30
                                    clip:true
                                    Label {
                                        id:trimtOW
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "Trimble TOW:"
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:ubloxtOW
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "U_Blox TOW:"
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqTOW
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "Q TOW:"
                                        font.pixelSize: 12
                                    }
                                }
                                ColumnLayout{
                                    spacing:30
                                    clip:true
                                    Label {
                                        id:trimTOWnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:ubloxTOWnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqTOWum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                }
                            }
                        }
                        Item {
                            id: cogtt
                            RowLayout {
                                spacing: 80
                                ColumnLayout{
                                    spacing:30
                                    clip:true
                                    Label {
                                        id:trimcogt
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "Trimble cogt:"
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:ubloxcogt
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "U_Blox cogt:"
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqcogt
                                        enabled: false
                                        clip:true
                                        font.bold: false
                                        x:-2
                                        text: "Q cogt:"
                                        font.pixelSize: 12
                                    }
                                }
                                ColumnLayout{
                                    spacing:30
                                    clip:true
                                    Label {
                                        id:trimcogtnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:ubloxcogtnum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                    Label {
                                        id:qqcogtum
                                        enabled: false
                                        font.bold: false
                                        clip:true
                                        x:-2
                                        text: "0"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 12
                                    }
                                }
                            }
                        }
                    }
                }
                GroupBox{
                    title: qsTr("Min/Max PoseAcc")
                    font.bold: true
                    implicitHeight: 110
                    implicitWidth: 310
                    Layout.alignment: Qt.AlignBottom
                    y:-200
                    RowLayout {
                        spacing: 30
                        ColumnLayout{
                            spacing:30
                            clip:true
//                                    Label {
//                                        id:trimposaccmax
//                                        enabled: false
//                                        clip:true
//                                        font.bold: false
//                                        x:-2
//                                        text: "Trimble PosAccuracy:"
//                                        font.pixelSize: 12
//                                    }
                            Label {
                                id:ubloxposaccmax
                                enabled: false
                                clip:true
                                font.bold: false
                                x:-2
                                text: "U_Blox PosAccuracy:"
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccmax
                                enabled: false
                                clip:true
                                font.bold: false
                                x:-2
                                text: "Q PosAccuracy:"
                                font.pixelSize: 12
                            }
                        }
                        ColumnLayout{
                            clip:true
                            spacing:30
//                                    Label {
//                                        id:trimposaccnummax
//                                        enabled: false
//                                        font.bold: false
//                                        clip:true
//                                        x:-2
//                                        text: "0"
//                                        horizontalAlignment: Text.AlignHCenter
//                                        font.pixelSize: 12
//                                    }
                            Label {
                                id:ubloxposaccnummax
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccnummax
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                        }
                        ColumnLayout{
                            clip:true
                            spacing:30
//                                    Label {
//                                        id:trimposaccnummin
//                                        enabled: false
//                                        font.bold: false
//                                        clip:true
//                                        x:-2
//                                        text: "0"
//                                        horizontalAlignment: Text.AlignHCenter
//                                        font.pixelSize: 12
//                                    }
                            Label {
                                id:ubloxposaccnummin
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccnummin
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                        }
                    }
                }
                GroupBox{
                    title: qsTr("Min/Max PDOP")
                    font.bold: true
                    implicitHeight: 160
                    implicitWidth: 310
                    Layout.alignment: Qt.AlignBottom
                    y:-200
                    RowLayout {
                        spacing: 50
                        ColumnLayout{
                            spacing:30
                            clip:true
                            Label {
                                id:trimposaccmaxPDOP
                                enabled: false
                                clip:true
                                font.bold: false
                                x:-2
                                text: "Trimble PDOP:"
                                font.pixelSize: 12
                            }
                            Label {
                                id:ubloxposaccmaxPDOP
                                enabled: false
                                clip:true
                                font.bold: false
                                x:-2
                                text: "U_Blox PDOP:"
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccmaxPDOP
                                enabled: false
                                clip:true
                                font.bold: false
                                x:-2
                                text: "Q PDOP:"
                                font.pixelSize: 12
                            }
                        }
                        ColumnLayout{
                            clip:true
                            spacing:30
                            Label {
                                id:trimposaccnummaxPDOP
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:ubloxposaccnummaxPDOP
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccnummaxPDOP
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                        }
                        ColumnLayout{
                            spacing:30
                            clip:true
                            Label {
                                id:trimposaccnumminPDOP
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:ubloxposaccnumminPDOP
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccnumminPDOP
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                        }
                    }
                }
                GroupBox{
                    title: qsTr("Min/Max Velocity")
                    font.bold: true
                    implicitHeight: 110
                    implicitWidth: 310
                    //                            anchors.fill: parent.bottom
                    Layout.alignment: Qt.AlignBottom
                    //                            y:-200
                    RowLayout {
                        spacing: 50
                        ColumnLayout{
                            spacing:30
                            clip:true
//                                    Label {
//                                        id:trimposaccmaxVel
//                                        enabled: false
//                                        clip:true
//                                        font.bold: false
//                                        x:-2
//                                        text: "Trimble Velocity:"
//                                        font.pixelSize: 12
//                                    }
                            Label {
                                id:ubloxposaccmaxVel
                                enabled: false
                                clip:true
                                font.bold: false
                                x:-2
                                text: "U_Blox Velocity:"
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccmaxVel
                                enabled: false
                                clip:true
                                font.bold: false
                                x:-2
                                text: "Q Velocity:"
                                font.pixelSize: 12
                            }
                        }
                        ColumnLayout{
                            clip:true
                            spacing:30
//                                    Label {
//                                        id:trimposaccnummaxVel
//                                        enabled: false
//                                        font.bold: false
//                                        clip:true
//                                        x:-2
//                                        text: "0"
//                                        horizontalAlignment: Text.AlignHCenter
//                                        font.pixelSize: 12
//                                    }
                            Label {
                                id:ubloxposaccnummaxVel
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccnummaxVel
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                        }
                        ColumnLayout{
                            spacing:30
                            clip:true
//                                    Label {
//                                        id:trimposaccnumminVel
//                                        enabled: false
//                                        font.bold: false
//                                        clip:true
//                                        x:-2
//                                        text: "0"
//                                        horizontalAlignment: Text.AlignHCenter
//                                        font.pixelSize: 12
//                                    }
                            Label {
                                id:ubloxposaccnumminVel
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccnumminVel
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                        }
                    }
                }
                GroupBox{
                    title: qsTr("Position Info")
                    font.bold: true
                    implicitHeight: 200
                    implicitWidth: 310
                    //                            anchors.fill: parent.bottom
                    Layout.alignment: Qt.AlignBottom
                    y:-200
                    RowLayout {
                        spacing: 30
                        ColumnLayout{
                            spacing:30
                            clip:true
                            Label {
                                id:qqposaccmaxTOW
                                enabled: false
                                clip:true
                                font.bold: false
                                x:-2
                                text: "TOW:"
                                font.pixelSize: 12
                            }
                            Label {
                                id:trimposaccmaxlat
                                enabled: false
                                clip:true
                                font.bold: false
                                x:-2
                                text: "Trimble lat/long:"
                                font.pixelSize: 12
                            }
                            Label {
                                id:ubloxposaccmaxlat
                                enabled: false
                                clip:true
                                font.bold: false
                                x:-2
                                text: "U_Blox lat/long:"
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccmaxlat
                                enabled: false
                                clip:true
                                font.bold: false
                                x:-2
                                text: "Q lat/long:"
                                font.pixelSize: 12
                            }
                        }
                        ColumnLayout{
                            spacing:30
                            Label {
                                id:qqposaccnummaxTOW
                                anchors.left: qqposaccmaxTOW.right
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            clip:true
                            Label {
                                id:trimposaccnummaxlat
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:ubloxposaccnummaxlat
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccnummaxlat
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                        }
                        ColumnLayout{
                            spacing:30
                            clip:true
                            anchors.bottom: parent.bottom
                            Label {
                                id:trimposaccnumminlat
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:ubloxposaccnumminlat
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                            Label {
                                id:qqposaccnumminlat
                                enabled: false
                                font.bold: false
                                clip:true
                                x:-2
                                text: "0"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 12
                            }
                        }
                    }
                }
                Button {
                    Layout.alignment: Qt.AlignCenter
                    id:clear
                    clip:true
                    enabled: true
                    font.bold:false
                    implicitHeight: 40
                    implicitWidth: 150
                    text: "Press to Clear All"
                    font.pixelSize: 10
                    onClicked: {

                        ParamScript.changeTextTo0(trimpdopcnum)
                        ParamScript.changeTextTo0(ubloxposaccnum)
                        ParamScript.changeTextTo0(ubloxpdopnum)
                        ParamScript.changeTextTo0(ubloxVELnum)
                        ParamScript.changeTextTo0(qqposaccnum)
                        ParamScript.changeTextTo0(qqpdopnum)
                        ParamScript.changeTextTo0(qqVELum)
                        ParamScript.changeTextTo0(qqTOWum)
                        ParamScript.changeTextTo0(qqposaccnummaxTOW)
                        ParamScript.changeTextTo0(qqlatLongAltnum)
                        ParamScript.changeTextTo0(qqposaccnummaxlat)
                        ParamScript.changeTextTo0(qqlatLongnum)
                        ParamScript.changeTextTo0(qqposaccnumminlat)
                        ParamScript.changeTextTo0(ubloxTOWnum)
                        ParamScript.changeTextTo0(ubloxlatLongAltnum)
                        ParamScript.changeTextTo0(ubloxposaccnummaxlat)
                        ParamScript.changeTextTo0(ubloxlatLongnum)
                        ParamScript.changeTextTo0(ubloxposaccnumminlat)
                        ParamScript.changeTextTo0(trimposaccnummaxPDOP)
                        ParamScript.changeTextTo0(trimposaccnumminPDOP)
                        ParamScript.changeTextTo0(ubloxposaccnummax)
                        ParamScript.changeTextTo0(ubloxposaccnummin)
                        ParamScript.changeTextTo0(ubloxposaccnummaxPDOP)
                        ParamScript.changeTextTo0(ubloxposaccnumminPDOP)
                        ParamScript.changeTextTo0(ubloxposaccnummaxVel)
                        ParamScript.changeTextTo0(ubloxposaccnumminVel)
                        ParamScript.changeTextTo0(qqposaccnummax)
                        ParamScript.changeTextTo0(qqposaccnummin)
                        ParamScript.changeTextTo0(qqposaccnummaxPDOP)
                        ParamScript.changeTextTo0(qqposaccnumminPDOP)
                        ParamScript.changeTextTo0(qqposaccnummaxVel)
                        ParamScript.changeTextTo0(qqposaccnumminVel)
                        ParamScript.changeTextTo0(trimTOWnum)
                        ParamScript.changeTextTo0(trimlatLongAltcnum)
                        ParamScript.changeTextTo0(trimposaccnummaxlat)
                        ParamScript.changeTextTo0(trimlatLongcnum)
                        ParamScript.changeTextTo0(trimposaccnumminlat)
                        ParamScript.changeTextTo0(trimlatcnum)
                        ParamScript.changeTextTo0(trimcogtnum)
                        ParamScript.changeTextTo0(qqcogtum)
                        ParamScript.changeTextTo0(ubloxcogtnum)


                        ParamScript.changeenabledToFalse(trimpdop)
                        ParamScript.changeenabledToFalse(trimpdopcnum)
                        ParamScript.changeenabledToFalse(ubloxposaccnum)
                        ParamScript.changeenabledToFalse(ubloxpdopnum)
                        ParamScript.changeenabledToFalse(ubloxVELnum)
                        ParamScript.changeenabledToFalse(qqposaccnum)
                        ParamScript.changeenabledToFalse(qqpdopnum)
                        ParamScript.changeenabledToFalse(qqVELum)
                        ParamScript.changeenabledToFalse(qqTOWum)
                        ParamScript.changeenabledToFalse(qqposaccnummaxTOW)
                        ParamScript.changeenabledToFalse(qqlatLongAltnum)
                        ParamScript.changeenabledToFalse(qqposaccnummaxlat)
                        ParamScript.changeenabledToFalse(qqlatLongnum)
                        ParamScript.changeenabledToFalse(qqposaccnumminlat)
                        ParamScript.changeenabledToFalse(ubloxTOWnum)
                        ParamScript.changeenabledToFalse(ubloxlatLongAltnum)
                        ParamScript.changeenabledToFalse(ubloxposaccnummaxlat)
                        ParamScript.changeenabledToFalse(ubloxlatLongnum)
                        ParamScript.changeenabledToFalse(ubloxposaccnumminlat)
                        ParamScript.changeenabledToFalse(trimposaccnummaxPDOP)
                        ParamScript.changeenabledToFalse(trimposaccmaxPDOP)
                        ParamScript.changeenabledToFalse(trimposaccnumminPDOP)
                        ParamScript.changeenabledToFalse(ubloxposaccnummax)
                        ParamScript.changeenabledToFalse(ubloxposaccnummin)
                        ParamScript.changeenabledToFalse(ubloxposaccnummaxPDOP)
                        ParamScript.changeenabledToFalse(ubloxposaccnumminPDOP)
                        ParamScript.changeenabledToFalse(ubloxposaccnummaxVel)
                        ParamScript.changeenabledToFalse(ubloxposaccnumminVel)
                        ParamScript.changeenabledToFalse(qqposaccnummax)
                        ParamScript.changeenabledToFalse(qqposaccnummin)
                        ParamScript.changeenabledToFalse(qqposaccnummaxPDOP)
                        ParamScript.changeenabledToFalse(qqposaccnumminPDOP)
                        ParamScript.changeenabledToFalse(qqposaccnummaxVel)
                        ParamScript.changeenabledToFalse(qqposaccnumminVel)
                        ParamScript.changeenabledToFalse(qqposaccmaxTOW)
                        ParamScript.changeenabledToFalse(trimtOW)
                        ParamScript.changeenabledToFalse(trimTOWnum)
                        ParamScript.changeenabledToFalse(trimlatLongAltcnum)
                        ParamScript.changeenabledToFalse(trimposaccnummaxlat)
                        ParamScript.changeenabledToFalse(trimlatLongAlt)
                        ParamScript.changeenabledToFalse(trimlatLongcnum)
                        ParamScript.changeenabledToFalse(trimposaccnumminlat)
                        ParamScript.changeenabledToFalse(trimposaccmaxlat)
                        ParamScript.changeenabledToFalse(trimlatcnum)
                        ParamScript.changeenabledToFalse(ubloxposacc)
                        ParamScript.changeenabledToFalse(ubloxlatLongAlt)
                        ParamScript.changeenabledToFalse(ubloxpdopp)
                        ParamScript.changeenabledToFalse(ubloxVEL)
                        ParamScript.changeenabledToFalse(ubloxtOW)
                        ParamScript.changeenabledToFalse(ubloxposaccmax)
                        ParamScript.changeenabledToFalse(ubloxposaccmaxPDOP)
                        ParamScript.changeenabledToFalse(ubloxposaccmaxVel)
                        ParamScript.changeenabledToFalse(ubloxposaccmaxlat)
                        ParamScript.changeenabledToFalse(trimcogt)
                        ParamScript.changeenabledToFalse(trimcogtnum)
                        ParamScript.changeenabledToFalse(ubloxcogtnum)
                        ParamScript.changeenabledToFalse(qqcogtum)
                        ParamScript.changeenabledToFalse(ubloxcogt)
                        ParamScript.changeenabledToFalse(qqposacc)
                        ParamScript.changeenabledToFalse(qqposaccmax)
                        ParamScript.changeenabledToFalse(qqposaccmaxlat)
                        ParamScript.changeenabledToFalse(qqlatLongAlt)
                        ParamScript.changeenabledToFalse(qqpdop)
                        ParamScript.changeenabledToFalse(qqposaccmaxPDOP)
                        ParamScript.changeenabledToFalse(qqTOW)
                        ParamScript.changeenabledToFalse(qqcogt)
                        ParamScript.changeenabledToFalse(qqposaccmaxVel)
                        ParamScript.changeenabledToFalse(qqVEL)
                        ParamScript.changeenabledToFalse(ubloxcogt)

                        lineFft2.clear();
                        lineFft3.clear();
                        lineFftlat.clear();
                        lineFftlat2.clear();
                        lineFftlat3.clear();
                        lineFftlong.clear();
                        lineFftlong2.clear();
                        lineFftlong3.clear();
                        lineFftheight.clear();
                        lineFftheight2.clear();
                        lineFftheight3.clear();
                        lineFftpdop.clear();
                        lineFftpdop2.clear();
                        lineFftpdop3.clear();
                        lineFftpvel2.clear();
                        lineFftpvel3.clear();
                        lineFftptow.clear();
                        lineFftptow2.clear();
                        lineFftptow3.clear();
                        lineFftpcogt.clear();
                        lineFftpcogt2.clear();
                        lineFftpcogt3.clear();
                        textConsole.clear();

                        cleanlogTrimble()
                        cleanlogUblox()
                        cleanlogQ()
                        csvStop()

                        for (var i = 0; i < originalModelqq.length; i++) {
                            ParamScript.changeenabledToTrue(newModelTRIMBLE[i])
                            ParamScript.changeenabledToTrue(newModelublox[i])
                            ParamScript.changeenabledToTrue(newModelqq[i])
                        }
                        ParamScript.changeVisibleToFalse(row1)
                        countertrimble=countertrimble-1;
                        if(countertrimble<=0){
                            countertrimble=0;
                        }

                        for (var i1 = 0; i1 < originalModelqq.length; i1++) {
                            ParamScript.changeenabledToTrue( newModelTRIMBLE[i1])
                            ParamScript.changeenabledToTrue(newModelublox[i1])
                            ParamScript.changeenabledToTrue(newModelqq[i1])
                        }
                        ParamScript.changeVisibleToFalse(row2)
                        countertrimble=countertrimble-1;
                        if(countertrimble<=0){
                            countertrimble=0;
                        }

                        for (var i2 = 0; i2 < originalModelqq.length; i2++) {
                            ParamScript.changeenabledToTrue(newModelTRIMBLE[i2])
                            ParamScript.changeenabledToTrue(newModelublox[i2])
                            ParamScript.changeenabledToTrue(newModelqq[i2])
                        }

                        ParamScript.changeVisibleToFalse(row3)
                        countertrimble=countertrimble-1;
                        if(countertrimble<=0){
                            countertrimble=0;
                        }
                    }
                }
            }
        }
    }
}
