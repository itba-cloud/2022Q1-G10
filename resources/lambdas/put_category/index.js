exports.handler = async (event) => {
	const { Client } = require('pg');
	const body = JSON.parse(event.body);
	const id = event.pathParameters.id;

	const query = {
		text: 'UPDATE TABLE categories SET name = $1 WHERE id = $2 RETURNING *',
		values: [body.name, id]
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
			'Access-Control-Allow-Methods': 'PUT'
		},
		body: resultString
	};

	return response;
};
