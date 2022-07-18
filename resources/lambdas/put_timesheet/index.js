exports.handler = async (event) => {
	const { Client } = require('pg');
	const body = event.body;
	const timesheet_id = event.pathParameters.id;

	const query = {
		text: 'UPDATE timesheets SET date = $1, task = $2 hours = $3, category_id = $4 WHERE id = $5 RETURNING *',
		values: [body.date, body.task, body.hours, body.category_id, timesheet_id]
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
