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

Dialog {
    property alias titleText: header.acceptText
    property alias model: view.model
    property alias delegate: view.delegate

    anchors.fill: parent

    Column {
        width: parent.width

        DialogHeader {
            id: header
            acceptText: qsTr("Add favorite")
        }

        SilicaListView {
            width: parent.width
            // TODO:
            height: 600
            id: view
        }

    }
// TODO:
property int selectedIndex
}
