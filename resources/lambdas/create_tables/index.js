exports.handler = async (event) => {
	const { Client } = require('pg');

	const query = {
		text: `CREATE TABLE categories (
            id SERIAL PRIMARY KEY,
            name TEXT
        );
        
        CREATE TABLE timesheets (
            id SERIAL PRIMARY KEY,
            user_id INT,
            category_id INT,
            _date timestamp,
            hours INT,
            FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
        );`
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
