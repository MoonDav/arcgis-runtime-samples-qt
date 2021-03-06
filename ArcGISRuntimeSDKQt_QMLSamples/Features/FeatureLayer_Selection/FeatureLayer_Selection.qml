// [WriteFile Name=FeatureLayer_Selection, Category=Features]
// [Legal]
// Copyright 2016 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// [Legal]

import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import Esri.ArcGISRuntime 100.0
import Esri.ArcGISExtras 1.1

Rectangle {
    width: 800
    height: 600

    property real scaleFactor: System.displayScaleFactor
    property string displayText: "No features selected. Click/Tap to select features."


    // Map view UI presentation at top
    MapView {
        id: mapView
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: messageBar.top
        }
        wrapAroundMode: Enums.WrapAroundModeDisabled

        Map {
            id: map
            BasemapStreets {}

            FeatureLayer {
                id: featureLayer

                selectionColor: "cyan"
                selectionWidth: 3

                // feature table
                ServiceFeatureTable {
                    id: featureTable
                    url: "http://sampleserver6.arcgisonline.com/arcgis/rest/services/DamageAssessment/FeatureServer/0"
                }
            }

            onLoadStatusChanged: {
                if (loadStatus === Enums.LoadStatusLoaded) {
                    mapView.setViewpoint(viewPoint);
                }
            }
        }

        // initial viewPoint
        ViewpointCenter {
            id: viewPoint
            Point {
                x: -10800000
                y: 4500000
                spatialReference: SpatialReference {
                    wkid: 102100
                }
            }
            scale: 3e7
        }

        onMouseClicked: {
            mapView.identifyLayerWithMaxResults(featureLayer, mouse.x, mouse.y, 22, 1000);
        }

        onIdentifyLayerStatusChanged: {
            if (identifyLayerStatus === Enums.TaskStatusCompleted) {
                // clear any previous selections
                featureLayer.clearSelection();

                // create an array to store the features
                var identifiedObjects = [];
                for (var i = 0; i < identifyLayerResult.geoElements.length; i++){
                    var elem = identifyLayerResult.geoElements[i];
                    identifiedObjects.push(elem);
                }
                // cache the number of identifyLayerResult
                var count = identifyLayerResult.geoElements.length;

                // select the features in the feature layer
                featureLayer.selectFeatures(identifiedObjects);
                displayText = "%1 %2 selected.".arg(count).arg(count > 1 ? "features" : "feature");
            }
        }
    }

    Rectangle {
        id: messageBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 30 * scaleFactor
        color: "lightgrey"
        border {
            width: 0.5 * scaleFactor
            color: "black"
        }

        Text {
            id: msgText
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 10 * scaleFactor
            }
            text: displayText
            font.pixelSize: 14 * scaleFactor
        }
    }

    // Neatline rectangle
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border {
            width: 0.5 * scaleFactor
            color: "black"
        }
    }
}
