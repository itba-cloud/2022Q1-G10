exports.handler = async (event) => {
	const { Client } = require('pg');

	const query = {
		text: 'SELECT *, timesheets.id FROM timesheets LEFT JOIN categories c on timesheets.category_id = c.id'
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
	const resultString = JSON.stringify(result.rows);

	client.end();

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
