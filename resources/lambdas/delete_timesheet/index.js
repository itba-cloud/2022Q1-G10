exports.handler = async (event) => {
	const { Client } = require('pg');

	const query = {
		text: 'DELETE FROM timesheets WHERE id = $1 RETURNING *',
		values: [event.pathParameters.id]
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
			'Access-Control-Allow-Methods': 'DELETE'
		},
		body: resultString
	};

	return response;
};
