FROM alfresco/alfresco-transform-core-aio:5.1.3

RUN cd tmp && mkdir -p BOOT-INF/classes

RUN cat <<EOL | tee /tmp/BOOT-INF/classes/PdfBoxMetadataExtractor_metadata_extract.properties
# Namespaces
namespace.prefix.cm=http://www.alfresco.org/model/content/1.0

# Mappings
author=cm:author
title=cm:title
created=cm:removeAfter
modified=cm:modified
EOL

USER root

RUN cd tmp && zip -u /usr/bin/alfresco-transform-core-aio.jar BOOT-INF/classes/PdfBoxMetadataExtractor_metadata_extract.properties

USER transform-all-in-one