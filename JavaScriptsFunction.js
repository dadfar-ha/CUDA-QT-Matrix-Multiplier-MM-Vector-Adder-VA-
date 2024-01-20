.pragma library

function changecolorgreen(textcolor) {
    return textcolor.icon.color="#008000"
}

function changecolorred(textcolor) {
    return textcolor.icon.color="#ff0000"
}

function changecolorcsvactive(textcolor) {
    return textcolor.icon.color="#428158"
}

function changecolorcsvnotactive(textcolor) {
    return textcolor.icon.color="#9cd7b6"
}

function changestatetoOn(switchc) {
    return switchc.text="On"
}

function changestatetoOff(switchc) {
    return switchc.text="Off"
}

function changeenabledToFalse(idd) {
    return idd.enabled=false
}

function changeenabledToTrue(idd) {
    return idd.enabled=true
}

function changeActiveToFalse(activator) {
    return activator.active=false
}

function changeActiveToTrue(activator) {
    return activator.active=true
}

function changeVisibleToFalse(visiblityy) {
    return visiblityy.visible=false
}

function changeVisibleToTrue(visiblityy) {
    return visiblityy.visible=true
}

function changeTextTo0(textchanger) {
    return textchanger.text="0"
}


