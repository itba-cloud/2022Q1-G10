exports.handler = async (event) => {
	const { Client } = require('pg');

	const body = JSON.parse(event.body);
	const query = {
		text: 'insert into timesheets (user_id, user_name, user_lastname, task, _date, hours, category_id) values($1, $2, $3, $4, $5, $6, $7) RETURNING *',
		values: [body.user_id, body.name, body.lastname, body.task, body.date, body.hours, body.category_id]
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
