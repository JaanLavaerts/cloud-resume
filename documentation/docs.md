After `terraform apply` the deployment token should be set in the Github Repo Secrets as `AZURE_STATIC_WEB_APPS_API_TOKEN`.
Get the token by running `terraform output deployment_token`.

Deploy the azure function manually using the publish script:

```bash
chmod +x functions/publish.sh
./functions/publish.sh
```
