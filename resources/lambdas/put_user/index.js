exports.handler = async (event) => {
	const { Client } = require('pg');

	const body = JSON.parse(event.body);
	const id = event.pathParameters.id;

	const query = {
		text: 'UPDATE TABLE users SET name = $1, lastname = $2, password = $4 WHERE id = $5 RETURNING *',
		values: [body.name, body.lastname, body.password, id]
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

	client.end();

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
