exports.handler = async (event) => {
	const { Client } = require('pg');

	const category_id = event.queryStringParameters.category_id;
	const query = {
		text: 'SELECT * FROM reports WHERE category_id = $1',
		values: [category_id]
	};

	const client = new Client({
		user: 'postgres',
		password: 'rootroot',
		host: 'itba-cloud-computing.cluster-cy0nwpl48zmv.us-east-1.rds.amazonaws.com',
		port: 5432,
		database: 'cloudcomputing'
	});

	await client.connect();

	const result = await client.query(query);
	const resultString = JSON.stringify(result.rows[0]);

	await client.end();

	const response = {
		statusCode: 200,
		headers: {
			'Access-Control-Allow-Origin': '*',
			'Access-Control-Allow-Methods': 'GET'
		},
		body: resultString
	};

	return response;
};
