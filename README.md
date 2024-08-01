# Changing Default Property Mappings for PDF Metadata Extraction in Alfresco Transform

A common requirement in Alfresco Transform is to change the mapping of out-of-the-box properties, such as mapping the `created` property to a custom property (e.g., `cm:removeAfter`) instead of the default `cm:created` (which is auditable and therefore not updatable) for a PDF file. This can be achieved by modifying the metadata extractor configuration files. These configuration files are found in the following locations:

- [Tika Engine Metadata Extractors](https://github.com/Alfresco/alfresco-transform-core/tree/master/engines/tika/src/main/resources)
- [Miscellaneous Engine Metadata Extractors](https://github.com/Alfresco/alfresco-transform-core/tree/master/engines/misc/src/main/resources)

## Modifying PDF Metadata Extractor Configuration

To map the `created` property to the content model property `cm:removeAfter` for PDF files, redefine the `PdfBoxMetadataExtractor_metadata_extract.properties` configuration as follows:

```properties
# Namespaces
namespace.prefix.cm=http://www.alfresco.org/model/content/1.0

# Mappings
author=cm:author
title=cm:title
created=cm:removeAfter
modified=cm:modified
```

### Important Notes:
1. **Namespace Specification**: All namespaces that the content model properties belong to must be specified, as shown above with `namespace.prefix.cm`.
2. **Case Sensitivity**: Property names are case-sensitive.

Additional instructions can be found in the [Metadata Extractors Documentation](https://docs.alfresco.com/content-services/latest/develop/repo-ext-points/metadata-extractors/).

## Applying the Configuration Using Docker

This project includes a sample [Dockerfile](Dockerfile) that applies the above configuration to the Docker Image `alfresco-transform-core-aio`. The Docker image can be built locally and used in a Docker Compose deployment.

### Building and Running the Docker Image

1. **Build the Docker Image**:
   ```sh
   docker build -t custom-transform-core-aio .
   ```

2. **Run the Docker Image**:
   ```sh
   docker run -p 8090:8090 custom-transform-core-aio
   ```

### Using Docker Compose

You can also include this custom image in a Docker Compose file for a complete deployment. 

Below is an example `compose.yaml` file:

```yaml
services:
  transform-core-aio:
    build:
      context: ./transform
    ports:
      - "8090:8090"
```

Include this `Dockerfile` in a folder `transform` on the same folder the `compose.yaml` file is living.

Deploy the stack using Docker Compose:

```sh
docker compose up
```

This setup ensures that your custom metadata mappings are applied correctly within the Alfresco Transform service.