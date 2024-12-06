PICAPPORT_VERSION=10-4-00
PICAPPORTAITAGGER_VERSION=2.0.0
PICAPPORTNONJPGTITLEFIELD_VERSION=1.0.0
PICAPPORTEIFTOOL_VERSION=1.0.0
PICAPPORTMETADATAANALYSER_VERSION=1.1.0
PICAPPORTIMAGGA_VERSION=1.0.0
PICAPPORTREVERSEENCODER_VERSION=1.0.0

mkdir -p /opt/picapport/add-ons
(cd /opt/picapport && curl -O https://www.picapport.de/download/$PICAPPORT_VERSION/picapport-headless.jar)
(cd /opt/picapport/add-ons && curl -O https://www.picapport.de/download/add-ons/pagpPicApportAITagger-$PICAPPORTAITAGGER_VERSION.zip)
(cd /opt/picapport/add-ons && curl -O https://www.picapport.de/download/add-ons/pagfNonJpgTitleField-$PICAPPORTNONJPGTITLEFIELD_VERSION.zip)
(cd /opt/picapport/add-ons && curl -O https://www.picapport.de/download/add-ons/pagpExifToolSimpleInfo-$PICAPPORTEIFTOOL_VERSION.zip)
(cd /opt/picapport/add-ons && curl -O https://www.picapport.de/download/add-ons/pagpMetadataAnalyser-$PICAPPORTMETADATAANALYSER_VERSION.zip)
(cd /opt/picapport/add-ons && curl -O https://www.picapport.de/download/add-ons/pagpImagga-$PICAPPORTIMAGGA_VERSION.zip)
(cd /opt/picapport/add-ons && curl -O https://www.picapport.de/download/add-ons/pagpGeoReverseEncoder-$PICAPPORTREVERSEENCODER_VERSION.zip)
(cd /opt/picapport && curl -O https://www.picapport.de/plugins/downloads/PicApportDcRawPlugin.zip)

unzip /opt/picapport/PicApportDcRawPlugin.zip PicApportDcRawPlugin.jar -d /opt/picapport/plugins
unzip /opt/picapport/PicApportDcRawPlugin.zip PicApportDcRawPlugin.properties -d /opt/picapport/plugins
rm /opt/picapport/PicApportDcRawPlugin.zip