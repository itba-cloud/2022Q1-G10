exports.handler = async (event) => {
	const { Client } = require('pg');
    const body = JSON.parse(event.body);

	const query = {
		text: 'SELECT * FROM timesheets WHERE user_id = $1',
        values: [body.user_id]
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
	const resultString = JSON.stringify(result);

	client.end();

	const response = {
		statusCode: 200,
		
		body: resultString
	};

	return response;
};
