# Configuration

This app expects configuration to be provided via environment variables.

## Variables

| Key           | Description                                                      | Optional                 | Default    | Notes                      |
    |---------------|------------------------------------------------------------------|--------------------------|------------|----------------------------|
| `PORT`        | The Port the service will listen on (required for GCP Cloud Run) | :heavy_check_mark:       | "8080"     |                            |
| `DB_PORT`     | The port to connect to the database to                           | :heavy_check_mark:       | "5432"     |                            |
| `DB_HOST`     | the database host                                                | :heavy_multiplication_x: | na         |                            |
| `DB_NAME`     | The database name                                                | :heavy_check_mark:       | "dpgraham" |                            |
| `DB_PASSWORD` | The database password                                            | :heavy_multiplication_x: | na         |                            |
| `DB_USER`     | The database username                                            | :heavy_multiplication_x: | na         |                            |
| `GIN_MODE`    | The GIN framework mode of operations                             | :heavy_check_mark:       | "Release"  | gin has exported constants |

.
