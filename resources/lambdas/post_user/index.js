exports.handler = async (event) => {
	const { Client } = require('pg');
	const body = event.body;
	const query = {
		text: 'INSERT INTO users (name, lastname, email, password) VALUES ($1, $2, $3, $4) RETURNING *',
		values: [body.name, body.lastname, body.email, body.password]
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
