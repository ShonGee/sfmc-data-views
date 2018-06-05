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
1. Create an Automation with the SQL queries in ```Data_Views.sql``` 
	1. Most queries are to be used with Update, except where noted otherwise



# Create SOAP Envelope of Contact Builder Salesforce DE

1. Save javascript content in ```SFMC Create DE SOAP Envelope``` as a Chrome Snippet
1. Run Chrome Snippet on a Salesforce Synced DE in Contact Builder
1. Copy the envelope from the Developer Console output
1. Save in Postman using appropriate environment variables as above  
1. Check for any ... of any fields that are too long and adjust
1. Change the ```<CustomerKey>User</CustomerKey>
				 <Name>User</Name>
				 <CategoryID>5279</CategoryID>``` as appropriate.
1. Run in Postman. 