import QtQuick 2.0
import QtCharts 2.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Controls.Material 2.3
ChartView {
    id: root
    signal zoomChanged(var x,var y,var width,var height)
    property bool flagclick: true
    theme:  ChartView.ChartThemeDark
    anchors.margins: -10

    function flagClickedFunc(dd)
    {
        console.log("oomadddd")
        flagclick=dd
    }

    Text {
        id: mapPonit
        color: "#37d437"
        font.pointSize: 8
        opacity: 0.7
    }

    Text {
        visible: false
        id: mapPonit2
        color: "#ea1e1e"
        text: "\u25CF"
        font.pointSize: 10
        font.family: "icons"
        opacity: 0.7
    }

    MouseArea{
        anchors.fill: parent
        property double mousePressedX: 0
        property double mousePressedY: 0
        property bool leftButton: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        propagateComposedEvents: true
        //                    onDoubleClicked: chart1.zoomReset()
        onDoubleClicked: {
            root.zoomReset()
            //                        cp.rescaleChart1()
        }

        onClicked: {
            var chartCoords = root.mapToValue(Qt.point(mouseX, mouseY));
            console.log( chartCoords.x + ", y: " + chartCoords.y);
            mapPonit.text = chartCoords.x + ", y: " + chartCoords.y;
            mapPonit.x = mouse.x;
            mapPonit.y = mouse.y-30;
            mapPonit2.x = mouse.x;
            mapPonit2.y = mouse.y;
            mapPonit2.visible=true
        }

        onPressed: {
            if(mouse.modifiers & Qt.ControlModifier)
                mouse.accepted = false;

            //            console.log(mouseX,mouseY)
            mousePressedX = mouseX
            mousePressedY = mouseY
            rectZoom.x = mouseX
            if(mouse.button == Qt.LeftButton)
            {
                rectZoom.y = mouseY
                leftButton = true
            }
            else
            {
                rectZoom.y = plotArea.y
                leftButton = false
            }

            rectZoom.width = 0
            rectZoom.height = 0
            rectZoom.visible = true
            //            mouse.accepted = false;
        }

        onPositionChanged: {
            if(rectZoom.visible){
                rectZoom.width = mouseX-rectZoom.x
                //                rectZoom.height = mouseY-rectZoom.y
                if(leftButton)
                    rectZoom.height = mouseY-rectZoom.y
                else
                    rectZoom.height = plotArea.height
            }
        }

        onReleased: {
            //            console.log(mouseX,mouseY)

            //            console.log(mousePressedX,mousePressedY,mouseX,mouseY)
            var x = Math.min(mousePressedX,mouseX)
            var y = Math.min(mousePressedY,mouseY)
            var width = Math.abs(mouseX-mousePressedX)
            var height
            if(mouse.button == Qt.LeftButton)
                height = Math.abs(mouseY-mousePressedY)
            else
                height = plotArea.height

            root.zoomIn(Qt.rect(x,y, width, height))
            rectZoom.visible = false;
            zoomChanged(x,y,width,height)
            mouse.accepted = false;
        }

        onWheel: {
            if(wheel.angleDelta.y > 0){
                root.zoom(1.2)
            }
            else{
                root.zoom(0.8)
            }
        }
    }
    Rectangle {
        id: rectZoom
        color: "blue"
        opacity: 0.5
        visible: false
    }
}


