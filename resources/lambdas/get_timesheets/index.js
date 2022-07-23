exports.handler = async (event) => {
	const { Client } = require('pg');

	const queryParams = event.queryStringParameters;

	const query = {
		text: 'SELECT *, timesheets.id FROM timesheets LEFT JOIN categories c on timesheets.category_id = c.id WHERE TRUE'
	};

	if (queryParams != null) {
		if (queryParams.category_id) {
			query.text += ` AND timesheets.category_id = ${queryParams.category_id}`;
		}
		if (queryParams.user_id) {
			query.text += ` AND timesheets.user_id = ${queryParams.user_id}`;
		}

		if (queryParams.month) {
			query.text += ` AND EXTRACT (month FROM timesheets._date) = ${queryParams.month}`;
		}
	}

	query.text += 'ORDER BY timesheets._date';

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
