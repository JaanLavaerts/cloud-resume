import azure.functions as func
from azure.cosmos import CosmosClient, exceptions
import logging
import os

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.route(route="IncrementVisitorCounter")
def IncrementVisitorCounter(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    COSMOS_CONNECTION_STRING = os.getenv("COSMOS_CONNECTION_STRING")

    client = CosmosClient.from_connection_string(COSMOS_CONNECTION_STRING)
    database_name = 'visitors-database'
    container_name = 'visitors-container'

    database = client.get_database_client(database_name)
    container = database.get_container_client(container_name)

    try:
        item = container.read_item(item='visitor_count', partition_key='visitor_count')
        item['count'] += 1
        container.replace_item(item=item, body=item)
    except exceptions.CosmosResourceNotFoundError:
        item = {'id': 'visitor_count', 'count': 1}
        container.create_item(body=item)

    return func.HttpResponse(
        body=f'{{"visitor_count": {item["count"]}}}',
        status_code=200,
        mimetype="application/json"
    )
