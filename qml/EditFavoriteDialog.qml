/*
 * This file is part of the Meegopas, more information at www.gitorious.org/meegopas
 *
 * Author: Jukka Nousiainen <nousiaisenjukka@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * See full license at http://www.gnu.org/licenses/gpl-3.0.html
 */

import QtQuick 2.1
import Sailfish.Silica 1.0
import "favorites.js" as Favorites

Dialog {
    id: edit_dialog
    property alias name: editTextField.text
    property string coord
    property string old_name: ""
    property variant favoritesModel

    canAccept: name.text != ''

    onAccepted: {
        if("OK" == Favorites.updateFavorite(edit_dialog.name, edit_dialog.coord, favoritesModel)) {

            /* update shortcuts, if exists */
            if(Shortcut.checkIfExists(edit_dialog.old_name)) {
                Shortcut.removeShortcut(edit_dialog.old_name)
                Shortcut.toggleShortcut(edit_dialog.name, edit_dialog.coord)
            }

            if(Shortcut.checkIfCyclingExists(edit_dialog.old_name)) {
                Shortcut.removeCyclingShortcut(edit_dialog.old_name)
                Shortcut.toggleCyclingShortcut(edit_dialog.name, edit_dialog.coord)
            }

            favoritesModel.clear()
            Favorites.getFavorites(favoritesModel)

        }
    }

    Column {
        anchors.fill: parent

        DialogHeader {
            acceptText: qsTr("Edit favorite")
        }

        Label {
            text: qsTr("Edit favorite name")
            font.pixelSize: Theme.fontSizeMedium
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Qt.AlignCenter
            font.bold: true
            color: Theme.primaryColor
        }

        Spacing {}

        TextField {
            id: editTextField
            width: parent.width

            Image {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/clear.png"
                visible: (editTextField.activeFocus)

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        editTextField.text = ''
                    }
                }
            }

            Keys.onReturnPressed: {
                editTextField.platformCloseSoftwareInputPanel()
                parent.focus = true
            }
        }
    }
}
