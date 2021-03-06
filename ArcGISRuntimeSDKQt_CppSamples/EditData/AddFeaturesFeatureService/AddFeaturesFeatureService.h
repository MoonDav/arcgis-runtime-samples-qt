// [WriteFile Name=AddFeaturesFeatureService, Category=EditData]
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

#ifndef ADD_FEATURES_FEATURE_SERVICE_H
#define ADD_FEATURES_FEATURE_SERVICE_H

namespace Esri
{
    namespace ArcGISRuntime
    {
        class Map;
        class MapQuickView;
        class FeatureLayer;
        class ServiceFeatureTable;
    }
}

#include <QQuickItem>

class AddFeaturesFeatureService : public QQuickItem
{
    Q_OBJECT

public:
    AddFeaturesFeatureService(QQuickItem* parent = 0);
    ~AddFeaturesFeatureService();

    void componentComplete() Q_DECL_OVERRIDE;

private:
    void connectSignals();

private:
    Esri::ArcGISRuntime::Map* m_map;
    Esri::ArcGISRuntime::MapQuickView* m_mapView;
    Esri::ArcGISRuntime::FeatureLayer* m_featureLayer;
    Esri::ArcGISRuntime::ServiceFeatureTable* m_featureTable;
};

#endif // ADD_FEATURES_FEATURE_SERVICE_H

