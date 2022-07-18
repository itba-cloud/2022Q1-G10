exports.handler = async (event) => {
	const { Client } = require('pg');

	const query = {
		text: 'SELECT * FROM timesheets WHERE id = $1',
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

	client.end();

	const response = {
		statusCode: 200,
		body: resultString
	};

	return response;
};
