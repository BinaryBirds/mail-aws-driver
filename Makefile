test: env
	swift test --parallel

env:
	echo 'REGION="eu-central-1"' > .env.testing
