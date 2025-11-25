## Deploy function

Deploy the azure function manually using the publish script:

```bash
chmod +x functions/publish.sh
./functions/publish.sh
```

## Required GitHub Secrets

To ensure the GitHub Actions workflows function correctly, the following secrets must be added to your repository:

1. **`ACR_USERNAME` and `ACR_PASSWORD`**: These are the credentials for your Azure Container Registry. You can retrieve them using the Azure CLI:

   ```bash
   az acr credential show --name jaanresumecontainerreg
   ```

2. **`AZURE_WEBAPP_PUBLISH_PROFILE`**: The publish profile for your Azure Web App. Retrieve it from the Azure Portal:
   - Navigate to your Web App.
   - Click on **Get publish profile** under **Overview**.
   - Download the file and use its content as the value for this secret.
