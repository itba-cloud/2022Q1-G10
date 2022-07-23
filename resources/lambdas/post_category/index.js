//postCategory
exports.handler = async (event) => {
	const { Client } = require('pg');
	const body = JSON.parse(event.body);

	const query = {
		text: 'insert into categories (name) values($1) RETURNING *',
		values: [body.name]
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
		statusCode: 201,
		headers: {
			'Access-Control-Allow-Origin': '*',
			'Access-Control-Allow-Methods': 'POST'
		},
		body: resultString
	};

	return response;
};
