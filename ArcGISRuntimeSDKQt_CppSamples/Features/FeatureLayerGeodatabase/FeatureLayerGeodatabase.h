// [WriteFile Name=FeatureLayerGeodatabase, Category=Features]
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

#ifndef FEATURE_LAYER_GEODATABASE_H
#define FEATURE_LAYER_GEODATABASE_H

namespace Esri
{
    namespace ArcGISRuntime
    {
        class Map;
        class MapQuickView;
        class Geodatabase;
    }
}

#include <QQuickItem>

class FeatureLayerGeodatabase : public QQuickItem
{
    Q_OBJECT

public:
    FeatureLayerGeodatabase(QQuickItem* parent = 0);
    ~FeatureLayerGeodatabase();

    void componentComplete() Q_DECL_OVERRIDE;

private:
    Esri::ArcGISRuntime::Map* m_map;
    Esri::ArcGISRuntime::MapQuickView* m_mapView;
    Esri::ArcGISRuntime::Geodatabase* m_geodatabase;
    QString m_dataPath;
};

#endif // FEATURE_LAYER_GEODATABASE_H

