# sfmc-data-views
Salesforce Marketing Cloud Data View SOAP Envelopes

# Instructions
1. Download Create Data Views.postman_collection.json and import it as a collection to Postman
1. Add the following as environment variables: 
	1. {{soapUsername}} - your API username
	1. {{soapPassword}} - your API password
	1. {{soapEndPoint}} - your Endpoint from the list [here](https://developer.salesforce.com/docs/atlas.en-us.noversion.mc-apis.meta/mc-apis/wsdl-endpoint-links.htm)
1. Change the folder location ```<CategoryID>5348</CategoryID>``` to the relevant location (use browser developer tools to find the folder id), or comment out the folder
1. Run each SOAP call. 