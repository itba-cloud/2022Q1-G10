exports.handler = async (event) => {
	const { Client } = require('pg');

	const query = {
		text: `CREATE TABLE IF NOT EXISTS categories (
            id SERIAL PRIMARY KEY,
            name TEXT NOT NULL
        );
        
        CREATE TABLE IF NOT EXISTS timesheets (
            id SERIAL PRIMARY KEY,
            user_id INT NOT NULL,
			task TEXT NOT NULL,
            category_id INT NOT NULL,
            _date DATE NOT NULL,
            hours FLOAT NOT NULL,
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
